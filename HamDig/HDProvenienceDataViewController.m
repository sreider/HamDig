//
//  HDProvenienceDataViewController.m
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//


#import "HDProvenienceDataViewController.h"
#import "HDLevelFormObject.h"   
#import "HDAppDelegateProtocol.h"
#import "HDPopovers.h"
#import "HDAppDelegate.h"

@interface HDProvenienceDataViewController ()

//picker wheel stuff to be moved
@property (strong, nonatomic) NSArray *areaNumArray;
@property (strong, nonatomic) NSArray *areaTypeArray;
@property (strong, nonatomic) NSArray *screenSizeArray;
@property (strong, nonatomic) NSArray *excavationIntervalArray;

// excavators
@property int excavatorLoc;
@property NSMutableArray *excavators;

// control scroll view for moving view up when keyboard is called
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextField *activeField;

// Popovers
@property (nonatomic, strong) UIPopoverController *areaPopover;
@property (nonatomic, strong) UIPopoverController *excavationPopover;
@property (nonatomic, strong) UIPopoverController *screenSizePopover;

@property (nonatomic, strong) id lastTappedButton;

@end

@implementation HDProvenienceDataViewController


- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}

- (IBAction)saveForm:(id)sender {
    
    /* I think this should be moved to a new view controller file for the
     real save button that shows up on the popover. The save buttons on the
     provenience form and others just opens up the popover. Shouldn't the real
     work be done in that popover? */
    
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    [theLevelFormObject save];
}

/*
POPOVER STUFF - now with saving when popover closes!
 */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.lastTappedButton = nil;
    
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    if ([theLevelFormObject.areaDescription  isEqualToString: @"OTHER"]){
        [areaDescription becomeFirstResponder];
    }
    else
        areaDescription.text = theLevelFormObject.areaDescription;
 
    if ([theLevelFormObject.excavationInterval isEqualToString:@"OTHER"]){
        [excavationInterval becomeFirstResponder];
    }
    else
        excavationInterval.text = theLevelFormObject.excavationInterval;
    
    screenSize.text = theLevelFormObject.screenSize;
    
    NSLog(@"Dismissed Popover");
}

// three different showPopovers for the three different windows
- (IBAction)showAreaPopover:(id)sender {
    UITextField *tappedButton = (UITextField *) sender;
    [self.areaPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;
}

- (IBAction)showExcavationPopover:(id)sender {
    UITextField *tappedButton = (UITextField *) sender;
    [self.excavationPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;
}

- (IBAction)showScreenSizePopover:(id)sender {
    UITextField *tappedButton = (UITextField *) sender;
    [self.screenSizePopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;
}


- (void)viewDidLoad
{
    // I know this is a mess but I'll clean this up later!! This was just a rushed example          -ES
    
    [super viewDidLoad];
   
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentlyEditing) {
        NSLog(@"Editing flag is on");
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary *currentDict = [appDelegate.allForms objectAtIndex:i];
        // save the form's title
        NSString *currentTitle = [currentDict objectForKey:@"formTitle"];
        //NSLog(@"Editing form with");
        NSLog(@"Editing: %@", currentTitle);
        
        // prepopulating here
        stratum.text = [currentDict objectForKey:@"stratum"];
        stratumLevel.text = [currentDict objectForKey:@"stratumLevel"];
        //datePicker.date = [currentDict objectForKey:@"date"];
        level.text = [currentDict objectForKey:@"level"];
        totalLevels.text = [currentDict objectForKey:@"totalLevels"];
        areaDescription.text = [currentDict objectForKey:@"areaDescription"];
        unitEasting.text = [currentDict objectForKey:@"unitEasting"];
        unitNorthing.text = [currentDict objectForKey:@"unitNorthing"];
        unitSizeX.text = [currentDict objectForKey:@"unitSizeX"];
        unitSizeY.text = [currentDict objectForKey:@"unitSizeY"];
        verticalDatumID.text = [currentDict objectForKey:@"verticalDatumID"];
        datumStringElevation.text = [currentDict objectForKey:@"datumStringElevation"];
        excavationInterval.text = [currentDict objectForKey:@"excavationInterval"];
        screenSize.text = [currentDict objectForKey:@"screenSize"];
        self.excavators = [currentDict objectForKey:@"excavators"];
        self.excavatorLoc = 0;
        excavatorsView.contentSize = CGSizeMake(280, self.excavatorLoc + 35);
        for (int i=0; i<[self.excavators count]; i++) {
            [excavatorsView addSubview:[[self.excavators objectAtIndex:i] objectAtIndex:0]];
            [excavatorsView addSubview:[[self.excavators objectAtIndex:i] objectAtIndex:1]];
            self.excavatorLoc += 35;
            excavatorsView.contentSize = CGSizeMake(280, self.excavatorLoc);
        }
    }
    else{
        self.excavators = [[NSMutableArray alloc] init];
    }
    
    self.areaNumArray = [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", nil];
    self.areaTypeArray = [[NSArray alloc] initWithObjects: @"Extramural", @"Housepit", @"Midden", @"--OTHER--", nil];
    self.screenSizeArray = [[NSArray alloc] initWithObjects: @"1/8 inch", @"1/4 inch", @"1/2 inch", @"2 mm", @"4 mm", @"6 mm", nil];
    self.excavationIntervalArray = [[NSArray alloc] initWithObjects:@"5 cm", @"10 cm", @"15 cm", @"--OTHER--", nil];
    
    // for use when calling/dismissing keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
/*
    Popover instantiation... Basically this creates the popover view somewhat programatically so that it can do stuff when its dismissed
 */
    HDPopovers *areaContent = [self.storyboard instantiateViewControllerWithIdentifier:@"areaPopover"];
    self.areaPopover = [[UIPopoverController alloc] initWithContentViewController:areaContent];
    self.areaPopover.delegate = self;
    
    HDPopovers *excavationContent = [self.storyboard instantiateViewControllerWithIdentifier:@"excavationPopover"];
    self.excavationPopover = [[UIPopoverController alloc] initWithContentViewController:excavationContent];
    self.excavationPopover.delegate = self;
    
    HDPopovers *screenSizeContent = [self.storyboard instantiateViewControllerWithIdentifier:@"screenSizePopover"];
    self.screenSizePopover = [[UIPopoverController alloc] initWithContentViewController:screenSizeContent];
    self.screenSizePopover.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
//When you finish editing a text field, saves the current values on the page.
{
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
     //   NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
     //                                                       dateStyle:NSDateFormatterShortStyle
     //                                                      timeStyle:NSDateFormatterFullStyle];
        
    theLevelFormObject.stratum = stratum.text;
    theLevelFormObject.stratumLevel = stratumLevel.text;

    theLevelFormObject.date = (NSString*)datePicker.date;
   
        
        
    theLevelFormObject.level = level.text;
    theLevelFormObject.totalLevels = totalLevels.text;
    theLevelFormObject.unitEasting = unitEasting.text;
    theLevelFormObject.unitNorthing = unitNorthing.text;
    theLevelFormObject.unitSizeX = unitSizeX.text;
    theLevelFormObject.unitSizeY = unitSizeY.text;
    theLevelFormObject.verticalDatumID = verticalDatumID.text;
    theLevelFormObject.datumStringElevation = datumStringElevation.text;
    
   
    // Fill dictionary for each form...
    
    // should this be done in our void save method?
    // I don't think so. I think our void save method should be just for
    // saving theNewLevelForm to the array -SR
    
    // array is now being save from the save button, not void save
    // do we still need the void save method for anything?      -ES
    
    // Provenience Data
    
    if (!appDelegate.currentlyEditing){
        [theLevelFormObject.theNewLevelForm setObject:stratum.text forKey:@"stratum"];
        [theLevelFormObject.theNewLevelForm setObject:stratumLevel.text forKey:@"stratumLevel"];
        //[theLevelFormObject.theNewLevelForm setObject:(NSString*)datePicker.date forKey:@"date"];
        [theLevelFormObject.theNewLevelForm setObject:level.text forKey:@"level"];
        [theLevelFormObject.theNewLevelForm setObject:totalLevels.text forKey:@"totalLevels"];
        [theLevelFormObject.theNewLevelForm setObject:areaDescription.text forKey:@"areaDescription"];
        [theLevelFormObject.theNewLevelForm setObject:unitEasting.text forKey:@"unitEasting"];
        [theLevelFormObject.theNewLevelForm setObject:unitNorthing.text forKey:@"unitNorthing"];
        [theLevelFormObject.theNewLevelForm setObject:unitSizeX.text forKey:@"unitSizeX"];
        [theLevelFormObject.theNewLevelForm setObject:unitSizeY.text forKey:@"unitSizeY"];
        [theLevelFormObject.theNewLevelForm setObject:verticalDatumID.text forKey:@"verticalDatumID"];
        [theLevelFormObject.theNewLevelForm setObject:datumStringElevation.text forKey:@"datumStringElevation"];
        [theLevelFormObject.theNewLevelForm setObject:excavationInterval.text   forKey:@"excavationInterval"];
        [theLevelFormObject.theNewLevelForm setObject:screenSize.text forKey:@"screenSize"];
    
        // date to string -SR
        NSDate *d = datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy'-'MM'-'dd"];
        NSString *stringFromDate = [formatter stringFromDate:d];
        [theLevelFormObject.theNewLevelForm setObject:stringFromDate forKey:@"date"];
    }
    
    else{
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary * currentDict = [appDelegate.allForms objectAtIndex:i];
        [currentDict setObject:stratum.text forKey:@"stratum"];
        [currentDict setObject:stratumLevel.text forKey:@"stratumLevel"];
        // HERE: date picker not working for prepopulating
        // not sure how to prepopulate datePicker, any thoughts?     -ES
        
        //[currentDict setObject:(NSString*)datePicker.date forKey:@"date"];
        
        [currentDict setObject:level.text forKey:@"level"];
        [currentDict setObject:totalLevels.text forKey:@"totalLevels"];
        [currentDict setObject:areaDescription.text forKey:@"areaDescription"];
        [currentDict setObject:unitEasting.text forKey:@"unitEasting"];
        [currentDict setObject:unitNorthing.text forKey:@"unitNorthing"];
        [currentDict setObject:unitSizeX.text forKey:@"unitSizeX"];
        [currentDict setObject:unitSizeY.text forKey:@"unitSizeY"];
        // HERE: still need to prepopulate excavators       -ES
        [currentDict setObject:verticalDatumID.text forKey:@"verticalDatumID"];
        [currentDict setObject:datumStringElevation.text forKey:@"datumStringElevation"];
        [currentDict setObject:excavationInterval.text   forKey:@"excavationInterval"];
        [currentDict setObject:screenSize.text forKey:@"screenSize"];
        
        // date to string -SR
        NSDate *d = datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy'-'MM'-'dd"];
        NSString *stringFromDate = [formatter stringFromDate:d];
        [currentDict setObject:stringFromDate forKey:@"date"];

        
    
    }

    // used by Jen's keyboard stuff
    self.activeField = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
   [theTextField resignFirstResponder];
    return TRUE;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];

    if (textField == areaDescription && [theLevelFormObject.areaDescription isEqualToString:@"OTHER"]) {
        NSLog(@"at other");
    }
    else if (textField == excavationInterval && [theLevelFormObject.excavationInterval isEqualToString:@"OTHER"]){
        NSLog(@"at other");
    }
    else if (textField == areaDescription || textField == screenSize || textField == excavationInterval){
        [textField resignFirstResponder];
    }
    // used by Jen's keyboard stuff
    self.activeField = textField;
}


///////////////////Excavators/////////////////////
- (IBAction)addExcavator:(id)sender {
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    UITextField *excavator = [[UITextField alloc] initWithFrame:CGRectMake(2,self.excavatorLoc,200,30)];
    [excavator setBorderStyle:UITextBorderStyleRoundedRect];
    [excavatorsView addSubview:excavator];
    excavator.delegate = self;
    
    UIButton *del = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    del.frame = CGRectMake(210, self.excavatorLoc, 60, 30);
    [del setTitle:@"-delete-" forState:UIControlStateNormal];
    [excavatorsView addSubview:del];
    
    [del addTarget:self
            action:@selector(deleteExcavator:)
  forControlEvents:UIControlEventTouchUpInside];
    NSArray *exc = [NSArray arrayWithObjects: excavator, del, nil];
    
    [self.excavators addObject: exc];
    [theLevelFormObject.excavators addObject:exc];
    self.excavatorLoc += 35;
    
    excavatorsView.contentSize = CGSizeMake(280, self.excavatorLoc);
    
    
}

-(IBAction)deleteExcavator:(id)sender
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    int x = -1;
    for (int i=0; i<[self.excavators count]; i++) {
        if ([[self.excavators objectAtIndex:i] objectAtIndex:1] == sender) {
            //Remove graphics from window
            for (int j = 0; j < 2; j++)
                [[[self.excavators objectAtIndex:i] objectAtIndex:j] removeFromSuperview];
            self.excavatorLoc -= 35;
            excavatorsView.contentSize = CGSizeMake(280, self.excavatorLoc);
            //Remove artifact info from list
            [self.excavators removeObjectAtIndex:i];
            [theLevelFormObject.excavators removeObjectAtIndex:i];
            x = i;
        }
    }
    //Moves each following excavator entry up;
    for (int i=x; i<[self.excavators count]; i++) {
        for (int j = 0; j < 2; j++) {
            UIView *fieldId = [[self.excavators objectAtIndex:i] objectAtIndex:j];
            CGRect textFieldFrame = fieldId.frame;
            textFieldFrame.origin.y -= 35;
            fieldId.frame = textFieldFrame;
        }
    }
}

// allows fields hidden by the keyboard to become visible. (not sure if works as well with popover windows...?)
- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    self.scrollView.contentSize = self.view.bounds.size;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint origin = self.activeField.frame.origin;
    origin.y -= self.scrollView.contentOffset.y;
    //origin.y += self.activeField.frame.size.height;
    
    if (!CGRectContainsPoint(aRect, origin)) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillHide:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
