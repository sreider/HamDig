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
    
    //Add all existing material to curent popover. Implement. -LW
    //
    //
    //

}

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

    //To add data from dictionary to page -LW
    for (int i=0; i<[theLevelFormObject.artifacts count]; i++) {
        [self addArtifact:nil];
    }
    for (int i=0; i<[theLevelFormObject.features count]; i++) {
        [self addFeature:nil];
    }
    for (int i=0; i<[theLevelFormObject.samples count]; i++) {
        [self addSample:nil];
    }
//    self.artifacts = [theLevelFormObject.theNewLevelForm objectForKey:@"artifacts"];
//    self.features = [theLevelFormObject.theNewLevelForm objectForKey:@"features"];
//    self.samples = [theLevelFormObject.theNewLevelForm objectForKey:@"samples"];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    //Shows the artifacts popover on page load. -LW
    [artifactsButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    return TRUE;
    
}
- (int) addArtifactOrSample:(int)loc :(NSString*)artOrSam
{
    //Graphically adds a row to the Artifact or Env. Sample page -LW
    
    UITextField *type = [[UITextField alloc] initWithFrame:CGRectMake(50,loc,250,30)];
    UITextField *easting = [[UITextField alloc] initWithFrame:CGRectMake(320, loc, 80, 30)];
    UITextField *northing = [[UITextField alloc] initWithFrame:CGRectMake(420, loc, 80, 30)];
    UITextField *depth = [[UITextField alloc] initWithFrame:CGRectMake(520, loc, 80, 30)];
 
    [type setBorderStyle:UITextBorderStyleRoundedRect];
    [easting setBorderStyle:UITextBorderStyleRoundedRect];
    [northing setBorderStyle:UITextBorderStyleRoundedRect];
    [depth setBorderStyle:UITextBorderStyleRoundedRect];
    
    UIButton *del = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    del.frame = CGRectMake(620, loc, 60, 30);
    [del setTitle:@"-delete-" forState:UIControlStateNormal];
    
    NSArray *material = [NSArray arrayWithObjects: type, easting, northing, depth, del, nil];
    
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
    
    [self.view addSubview:type];
    [self.view addSubview:easting];
    [self.view addSubview:northing];
    [self.view addSubview:depth];
    [self.view addSubview:del];

    loc+= 50;
    return loc;
}


- (IBAction)addArtifact:(id)sender
{
    self.artifactLoc = [self addArtifactOrSample:self.artifactLoc:@"artifact"];
}

- (IBAction)addFeature:(id)sender
{
    //Graphically adds a row to the Feature page -LW
    
    UITextField *num = [[UITextField alloc] initWithFrame:CGRectMake(35,self.featureLoc,100,30)];
    UITextField *type = [[UITextField alloc] initWithFrame:CGRectMake(175, self.featureLoc, 250, 30)];
    [type setBorderStyle:UITextBorderStyleRoundedRect];
    [num setBorderStyle:UITextBorderStyleRoundedRect];
    
    UIButton *del = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    del.frame = CGRectMake(450, self.featureLoc, 60, 30);
    [del setTitle:@"-delete-"
            forState:UIControlStateNormal];
    [del addTarget:self
            action:@selector(deleteFeature:)
            forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *material = [NSArray arrayWithObjects: num, type, del, nil];
    [self.features addObject:material];
    
    [self.view addSubview:num];
    [self.view addSubview:type];
    [self.view addSubview:del];

    self.featureLoc += 50;
}

- (IBAction)addSample:(id)sender
{
    self.sampleLoc = [self addArtifactOrSample:self.sampleLoc:@"sample"];
}

- (void)deleteArtifact:(id)sender
{
    //Delete row from app visually
    //Delete artifact info from Dictionary -LW
    int x = [self.artifacts count];
    for (int i=0; i<[self.artifacts count]; i++) {
        if ([[self.artifacts objectAtIndex:i] objectAtIndex:4] == sender) {
            //Remove graphics from window -LW
            for (int j = 0; j < 5; j++) {
                [[[self.artifacts objectAtIndex:i] objectAtIndex:j] removeFromSuperview];
            }
            self.artifactLoc -= 50;
            
            //Remove artifact info from list -LW
            [self.artifacts removeObjectAtIndex:i];
            x = i;
        }
        if (x > i) {
            NSLog(@"greater!");
            for (int j = 0; j < 5; j++) {
                CGRect textFieldFrame = [[[self.artifacts objectAtIndex:i] objectAtIndex:j] frame];
                textFieldFrame.origin.y -= 50;
            }
        }
    }
    
}

- (void)deleteFeature:(id)sender
{
    //Delete row from app visually
    //Delete feature info from Dictionary -LW
}

- (void)deleteSample:(id)sender
{
    //Delete row from app visually
    //Delete env. sample info from Dictionary -LW
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
