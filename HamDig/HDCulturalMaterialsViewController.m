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
@property (nonatomic, strong) UIPopoverController *masterPopoverController;

@property (nonatomic, strong) id lastTappedButton;

@property int artifactLoc;
@property int featureLoc;
@property int sampleLoc;

@property (nonatomic, strong) NSMutableArray *artifacts;
@property (nonatomic, strong) NSMutableArray *features;
@property (nonatomic, strong) NSMutableArray *samples;

@property (nonatomic, strong) NSMutableDictionary * currentDict;

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
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.currentlyEditing)
        self.currentDict = [appDelegate.allForms objectAtIndex:appDelegate.currentDictIndex];
    else
        self.currentDict = theLevelFormObject.theNewLevelForm;

    self.artifacts = [self.currentDict objectForKey:@"artifacts"];
    self.features = [self.currentDict objectForKey:@"features"];
    self.samples = [self.currentDict objectForKey:@"samples"];
 
    //Locations for initial addition of cultural materials to page -LW
    self.artifactLoc = 0;
    self.featureLoc = 0;
    self.sampleLoc = 0;
    artifactsScroll.userInteractionEnabled = YES;
    samplesScroll.userInteractionEnabled = YES;
    featuresScroll.userInteractionEnabled = YES;
    
    artifactsScroll.contentSize = CGSizeMake(768, self.artifactLoc);
    featuresScroll.contentSize = CGSizeMake(400, self.featureLoc);
    samplesScroll.contentSize = CGSizeMake(768, self.sampleLoc);
    
    //To add existing cultural materials from the current level form object to page -LW
    for (int i=0; i<[self.artifacts count]; i++)
        for (int j=0; j<[self.artifacts[i] count]; j++) {
            [artifactsScroll addSubview:[[self.artifacts objectAtIndex:i] objectAtIndex:j]];
            self.artifactLoc += 50;
            artifactsScroll.contentSize = CGSizeMake(768, self.artifactLoc);
        }
    for (int i=0; i<[self.features count]; i++)
        for (int j=0; j<[self.features[i] count]; j++) {
            [featuresScroll addSubview:[[self.features objectAtIndex:i] objectAtIndex:j]];
            self.featureLoc += 50;
            featuresScroll.contentSize = CGSizeMake(400, self.featureLoc);
        }
    for (int i=0; i<[self.samples count]; i++)
        for (int j=0; j<[self.samples[i] count]; j++) {
            [samplesScroll addSubview:[[self.samples objectAtIndex:i] objectAtIndex:j]];
            self.sampleLoc += 50;
            samplesScroll.contentSize = CGSizeMake(768, self.sampleLoc);
        }
}

-(void)viewDidAppear:(BOOL)animated
{
    //Shows the artifacts popover on page load. -LW
   [artifactsButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.lastTappedButton = nil;
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
-(void)checkList:(UITextField*)textField :(NSMutableArray*)ary :(int)numObj
{
    for (int i=0; i < [ary count]; i++)
        for (int j=0; j<numObj; j++)
            if ([[ary objectAtIndex:i] objectAtIndex:j] == textField) {
                UITextField *txt =[[ary objectAtIndex:i] objectAtIndex:j];
                txt.text = textField.text;
            }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //Save value in correct list
    [self checkList:textField :self.artifacts :4];
    [self checkList:textField :self.samples :4];
    [self checkList:textField :self.features :1];
    
    [self.currentDict setObject:self.artifacts forKey:@"artifacts"];
    [self.currentDict setObject:self.samples forKey:@"samples"];
    [self.currentDict setObject:self.features forKey:@"features"];
}


////////////////////////
//Adding new materials: programmatically creates all of the UI objects for the user to interact with
//Also populates preexisting material's textfields.  -LW
////////////////////////

- (int) addArtifactOrSample:(int)loc :(NSString*)artOrSam  :(int)index :(UIView*)viewX
{
    UITextField *type = [[UITextField alloc] initWithFrame:CGRectMake(50,loc,250,30)];
    UITextField *easting = [[UITextField alloc] initWithFrame:CGRectMake(320, loc, 80, 30)];
    UITextField *northing = [[UITextField alloc] initWithFrame:CGRectMake(420, loc, 80, 30)];
    UITextField *depth = [[UITextField alloc] initWithFrame:CGRectMake(520, loc, 80, 30)];
 
    [type setBorderStyle:UITextBorderStyleRoundedRect];
    [easting setBorderStyle:UITextBorderStyleRoundedRect];
    [northing setBorderStyle:UITextBorderStyleRoundedRect];
    [depth setBorderStyle:UITextBorderStyleRoundedRect];

    [easting setKeyboardType: UIKeyboardTypeNumberPad];
    [northing setKeyboardType: UIKeyboardTypeNumberPad];
    [depth setKeyboardType: UIKeyboardTypeNumberPad];
    
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
        artifactsScroll.contentSize = CGSizeMake(768, self.artifactLoc + 50);
        [self.artifacts addObject:material];
        [self.currentDict setObject:self.artifacts forKey:@"artifacts"];
    }
    else {
        [del addTarget:self
                action:@selector(deleteSample:)
                forControlEvents:UIControlEventTouchUpInside];
        samplesScroll.contentSize = CGSizeMake(768, self.sampleLoc + 50);
        [self.samples addObject:material];
        [self.currentDict setObject:self.samples forKey:@"samples"];
    }
    return loc += 50;
}

-(void) addFeat:(BOOL)new :(int)index
{
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
    [self.currentDict setObject:self.features forKey:@"features"];

    [featuresScroll addSubview:type];
    [featuresScroll addSubview:del];
    
    type.delegate = self;
    
    self.featureLoc += 50;
    featuresScroll.contentSize = CGSizeMake(400, self.featureLoc);
}

//////////////////
//action methods attached to the + buttons on each of the popovers
//all call other methods with specifying parameters -LW
//////////////////

- (IBAction)addArtifact:(id)sender
{
   self.artifactLoc = [self addArtifactOrSample :self.artifactLoc :@"artifact" :-1 :artifactsScroll];
}

- (IBAction)addSample:(id)sender
{
    self.sampleLoc = [self addArtifactOrSample:self.sampleLoc:@"sample" :-1 :samplesScroll];
}

- (IBAction)addFeature:(id)sender
{
    //Graphically adds a row to the Feature page -LW
    [self addFeat:true :-1];
}

////////////////////////////////
//Deletes previously added material -LW
////////////////////////////////
//cnt is the number of fields in the row of the material
- (int) deleteMaterial:(id)sender :(NSMutableArray*)ary  :(int)loc :(int)cnt
{
    NSLog(@"deleting material");
    int x = -1;
    for (int i=0; i<[ary count]; i++) {
        if ([[ary objectAtIndex:i] objectAtIndex:cnt - 1] == sender) {
             //Remove graphics from window
            for (int j = 0; j < cnt; j++)
                [[[ary objectAtIndex:i] objectAtIndex:j] removeFromSuperview];
            loc -= 50;
 
            //Remove artifact info from list
            [ary removeObjectAtIndex:i];
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
    self.artifactLoc = [self deleteMaterial :sender :self.artifacts :self.artifactLoc :5];
    artifactsScroll.contentSize = CGSizeMake(768, self.artifactLoc);
    [self.currentDict setObject:self.artifacts forKey:@"artifacts"];
}

- (void)deleteFeature:(id)sender
{
    self.featureLoc = [self deleteMaterial :sender :self.features  :self.featureLoc :2];
    featuresScroll.contentSize = CGSizeMake(400, self.featureLoc);
    [self.currentDict setObject:self.features forKey:@"features"];
}

- (void)deleteSample:(id)sender
{
    self.sampleLoc = [self deleteMaterial :sender :self.samples :self.sampleLoc :5];
    samplesScroll.contentSize = CGSizeMake(768, self.sampleLoc);
    [self.currentDict setObject:self.samples forKey:@"samples"];
}
@end
