//
//  HDCulturalMaterialsViewController.m
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDCulturalMaterialsViewController.h"
#import "HDLevelFormObject.h"
#import "HDAppDelegateProtocol.h"
#import "HDAppDelegate.h"
#import "HDPopovers.h"

@interface HDCulturalMaterialsViewController ()

@property (nonatomic, strong) UIPopoverController *barButtonItemPopover;
@property (nonatomic, strong) UIPopoverController *detailViewPopover;
@property (nonatomic, strong) id lastTappedButton;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;

@property int artifactLoc;
@property int featureLoc;
@property int sampleLoc;
@property NSMutableArray *artifacts;
@property NSMutableArray *features;
@property NSMutableArray *samples;
@end

@implementation HDCulturalMaterialsViewController

- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    //Locations for initial addition of cultural materials to page -LW
    self.artifactLoc = 150;
    self.featureLoc = 130;
    self.sampleLoc = 150;
    
    self.artifacts = [[NSMutableArray alloc] init];
    self.samples = [[NSMutableArray alloc] init];
    self.features = [[NSMutableArray alloc] init];
    
    //To add data from the current level form object to page -LW
    for (int i=0; i<[theLevelFormObject.artifacts count]; i++)
        self.artifactLoc = [self addArtifactOrSample:self.artifactLoc :@"artifact" :false :i :artifactView :theLevelFormObject.artifacts];
    
    for (int i=0; i<[theLevelFormObject.features  count]; i++)
        [self addFeat:false :i];
    
    for (int i=0; i<[theLevelFormObject.samples count]; i++)
        self.sampleLoc = [self addArtifactOrSample:self.sampleLoc :@"sample" :false :i :sampleView :theLevelFormObject.samples];
}

-(void)viewDidAppear:(BOOL)animated
{
    //Shows the artifacts popover on page load. -LW
   [artifactsButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

//Popover stuff from Jen
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.lastTappedButton = nil;
    NSLog(@"Dismiss popover");
}

- (IBAction)showPopover:(id)sender
{
    UIButton *tappedButton = (UIButton *)sender;
    [self.detailViewPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;

}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return TRUE;
}

//Checks if the given array is the array the edited text field is in -LW
-(void)checkList:(UITextField*)textField :(NSMutableArray*)ary :(NSMutableArray*)lfAry :(int)numObj
{
    for (int i=0; i < [ary count]; i++)
        for (int j=0; j<numObj; j++)
            if ([[ary objectAtIndex:i] objectAtIndex:j] == textField) {
                UITextField *txt =[[lfAry objectAtIndex:i] objectAtIndex:j];
                txt.text = textField.text;
            }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];

    //Save value in correct list
    [self checkList:textField :self.artifacts :theLevelFormObject.artifacts :4];
    [self checkList:textField :self.samples :theLevelFormObject.samples :4];
    [self checkList:textField :self.features :theLevelFormObject.features :1];
}


////////////////////////
//Adding new materials: programmatically creates all of the UI objects for the user to interact with
//Also populates preexisting material's textfields.  -LW
////////////////////////

- (int) addArtifactOrSample:(int)loc :(NSString*)artOrSam :(BOOL)new :(int)index :(UIView*)viewX :(NSMutableArray*) lfAry
{

    UITextField *type = [[UITextField alloc] initWithFrame:CGRectMake(50,loc,250,30)];
    UITextField *easting = [[UITextField alloc] initWithFrame:CGRectMake(320, loc, 80, 30)];
    UITextField *northing = [[UITextField alloc] initWithFrame:CGRectMake(420, loc, 80, 30)];
    UITextField *depth = [[UITextField alloc] initWithFrame:CGRectMake(520, loc, 80, 30)];
 
    [type setBorderStyle:UITextBorderStyleRoundedRect];
    [easting setBorderStyle:UITextBorderStyleRoundedRect];
    [northing setBorderStyle:UITextBorderStyleRoundedRect];
    [depth setBorderStyle:UITextBorderStyleRoundedRect];
    
    //Adds fields to the coresponding popover view
    [viewX addSubview:type];
    [viewX addSubview:easting];
    [viewX addSubview:northing];
    [viewX addSubview:depth];

    //Attaches each newly added graphical object to the page delegate so they can be referred to in the HDCulturalMaterialsViewController class.
    type.delegate = self;
    easting.delegate = self;
    northing.delegate = self;
    depth.delegate = self;
    
    //Creates and adds the delete button to the corresponding popover view
    UIButton *del = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    del.frame = CGRectMake(620, loc, 60, 30);
    [del setTitle:@"-delete-" forState:UIControlStateNormal];
    [viewX addSubview:del];
   
    NSArray *material = [NSArray arrayWithObjects: type, easting, northing, depth, del, nil];
    
    //adds the delete action to the delete button.
    if ([artOrSam  isEqual: @"artifact"]){
        [del addTarget:self
                action:@selector(deleteArtifact:)
                forControlEvents:UIControlEventTouchUpInside];
        [self.artifacts addObject: material];
    }
    else {
        [del addTarget:self
                action:@selector(deleteSample:)
                forControlEvents:UIControlEventTouchUpInside];
        [self.samples addObject:material];
    }
    
    if (new)  //new material is not is level form
        [lfAry addObject:material];
    else{    //populate the text field with data from the existing form
        type.text = [[[lfAry objectAtIndex:index] objectAtIndex:0] text];
        easting.text = [[[lfAry objectAtIndex:index] objectAtIndex:1] text];
        northing.text = [[[lfAry objectAtIndex:index] objectAtIndex:2] text];
        depth.text = [[[lfAry objectAtIndex:index] objectAtIndex:3] text];
    }
    return loc += 50;
}

-(void) addFeat:(BOOL)new :(int)index
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    UITextField *type = [[UITextField alloc] initWithFrame:CGRectMake(30, self.featureLoc, 250, 30)];
    [type setBorderStyle:UITextBorderStyleRoundedRect];
    
    UIButton *del = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    del.frame = CGRectMake(320, self.featureLoc, 60, 30);
    [del setTitle:@"-delete-"
         forState:UIControlStateNormal];
    [del addTarget:self
            action:@selector(deleteFeature:)
  forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *material = [NSArray arrayWithObjects: type, del, nil];
    [self.features addObject:material];
    if (new)
        [theLevelFormObject.features addObject:material];
    else
        type.text = [[[theLevelFormObject.features objectAtIndex:index] objectAtIndex:0] text];
    
    [featureView addSubview:type];
    [featureView addSubview:del];
    
    type.delegate = self;
    
    self.featureLoc += 50;
}

//////////////////
//action methods attached to the + buttons on each of the popovers
//all call other methods with specifying parameters -LW
//////////////////

- (IBAction)addArtifact:(id)sender
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    self.artifactLoc = [self addArtifactOrSample :self.artifactLoc :@"artifact" :true :-1 :artifactView :theLevelFormObject.artifacts];
}

- (IBAction)addSample:(id)sender
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    self.sampleLoc = [self addArtifactOrSample:self.sampleLoc:@"sample" :true :-1 :sampleView :theLevelFormObject.samples];
}

- (IBAction)addFeature:(id)sender
{
    //Graphically adds a row to the Feature page -LW
    [self addFeat:true :-1];
    
}

////////////////////////////////
//Deletes previously added material -LW
////////////////////////////////

- (int) deleteMaterial:(id)sender :(NSMutableArray*)ary :(NSMutableArray*)lfAry :(int)loc :(int)cnt
{
 
    int x = -1;
    for (int i=0; i<[ary count]; i++) {
        if ([[ary objectAtIndex:i] objectAtIndex:cnt - 1] == sender) {
            //Remove graphics from window
            for (int j = 0; j < cnt; j++)
                [[[ary objectAtIndex:i] objectAtIndex:j] removeFromSuperview];
            loc -= 50;

            //Remove artifact info from list
            [ary removeObjectAtIndex:i];
            [lfAry removeObjectAtIndex:i];
            x = i;
        }
    }
   //Moves each following material entry up;
    for (int i=x; i<ary.count; i++) {
        for (int j = 0; j < cnt; j++) {
            UIView *fieldId = [[ary objectAtIndex:i] objectAtIndex:j];
            CGRect textFieldFrame = fieldId.frame;
            textFieldFrame.origin.y -= 50;
            fieldId.frame = textFieldFrame;
        }
    }
    return loc;
}

////////////////
//Methods that are attached to the "delete" button for each type of material
//All call the deleteMaterial method with identifying parameters -LW
////////////////

- (void)deleteArtifact:(id)sender
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    self.artifactLoc = [self deleteMaterial :sender :self.artifacts :theLevelFormObject.artifacts :self.artifactLoc :5];
}

- (void)deleteFeature:(id)sender
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    self.featureLoc = [self deleteMaterial :sender :self.features :theLevelFormObject.features :self.featureLoc :2];
}

- (void)deleteSample:(id)sender
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    self.sampleLoc = [self deleteMaterial :sender :self.samples :theLevelFormObject.samples :self.sampleLoc :5];
}
@end
