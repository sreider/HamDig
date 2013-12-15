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

// excavators
@property int excavatorLoc;
@property (nonatomic, strong) NSMutableArray *excavators;

// control scroll view for moving view up when keyboard is called
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextField *activeField;

// Popovers
@property (nonatomic, strong) UIPopoverController *areaPopover;
@property (nonatomic, strong) UIPopoverController *excavationPopover;
@property (nonatomic, strong) UIPopoverController *screenSizePopover;
@property (nonatomic, strong) UIPopoverController *stratumPopover;
@property (nonatomic, strong) UIPopoverController *datePopover;
@property (nonatomic, strong) id lastTappedButton;

@property bool areaFlag;
@property bool intervalFlag;
@property (nonatomic, strong) NSMutableDictionary * currentDict;

@end

@implementation HDProvenienceDataViewController

- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}

/*
POPOVER STUFF - now with saving when popover closes!
 */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
//    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    if (self.lastTappedButton == areaDescription){
        if ([[self.currentDict objectForKey:@"areaDescription"]  isEqualToString: @"OTHER"]){
            self.areaFlag = 1;
            [areaDescription becomeFirstResponder];
        }
        else
            areaDescription.text = [self.currentDict objectForKey:@"areaDescription"];
    }
    else if (self.lastTappedButton == excavationInterval){
        if ([[self.currentDict objectForKey:@"excavationInterval"] isEqualToString:@"OTHER"]){
            self.intervalFlag =1;
            [excavationInterval becomeFirstResponder];
        }
        else
            excavationInterval.text = [self.currentDict objectForKey:@"excavationInterval"];
    }
    else if (self.lastTappedButton == dateField){
        NSDateFormatter *toDateForm = [[NSDateFormatter alloc] init];
        [toDateForm setDateFormat:@"yyyy'-'MM'-'dd"];
        NSString *dateStr = [self.currentDict objectForKey:@"date"];
        NSDate *date = [toDateForm dateFromString: dateStr];
        
        // formating the date to read nicely [monthName, day, year]
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterLongStyle];
        NSString *stringFromDate = [formatter stringFromDate:date];
        dateField.text = stringFromDate;
    }
    else if (self.lastTappedButton == stratum)
        stratum.text = [self.currentDict objectForKey:@"stratum"];
 
    screenSize.text = [self.currentDict objectForKey:@"screenSize"];
 
    self.lastTappedButton = nil;
}

// four different showPopovers for the four different windows
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

- (IBAction)showStratumPopover:(id)sender {
    UITextField *tappedButton = (UITextField *) sender;
    [self.stratumPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;
}

- (IBAction)showDatePopover:(id)sender {
    UITextField *tappedButton = (UITextField *) sender;
    [self.datePopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    if (appDelegate.currentlyEditing) {
        int i = appDelegate.currentDictIndex;
        self.currentDict = [appDelegate.allForms objectAtIndex:i];
        
        // prepopulating here
        stratum.text = [self.currentDict objectForKey:@"stratum"];
        stratumLevel.text = [self.currentDict objectForKey:@"stratumLevel"];
        digName.text = [self.currentDict objectForKey:@"digName"];
        level.text = [self.currentDict objectForKey:@"level"];
        totalLevels.text = [self.currentDict objectForKey:@"totalLevels"];
        areaDescription.text = [self.currentDict objectForKey:@"areaDescription"];
        unitEasting.text = [self.currentDict objectForKey:@"unitEasting"];
        unitNorthing.text = [self.currentDict objectForKey:@"unitNorthing"];
        unitSizeX.text = [self.currentDict objectForKey:@"unitSizeX"];
        unitSizeY.text = [self.currentDict objectForKey:@"unitSizeY"];
        verticalDatumID.text = [self.currentDict objectForKey:@"verticalDatumID"];
        datumStringElevation.text = [self.currentDict objectForKey:@"datumStringElevation"];
        excavationInterval.text = [self.currentDict objectForKey:@"excavationInterval"];
        screenSize.text = [self.currentDict objectForKey:@"screenSize"];
        
        //Prepopulate the excavators view with all previously existing excavators
        self.excavators = [self.currentDict objectForKey:@"excavators"];
        self.excavatorLoc = 0;
        excavatorsView.contentSize = CGSizeMake(280, self.excavatorLoc + 35);
        for (int i=0; i<[self.excavators count]; i++) {
            [excavatorsView addSubview:[[self.excavators objectAtIndex:i] objectAtIndex:0]];
            [excavatorsView addSubview:[[self.excavators objectAtIndex:i] objectAtIndex:1]];
            self.excavatorLoc += 35;
            excavatorsView.contentSize = CGSizeMake(280, self.excavatorLoc);
        }
        // prepopulating the date
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [[NSDate alloc] init];
        NSString *dateStr = [self.currentDict objectForKey:@"date"];
        date = [format dateFromString: dateStr];
        NSLog(@"date: %@", date);
        
        // formating the date to read nicely [monthName, day, year]
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterLongStyle];
        NSString *stringFromDate = [formatter stringFromDate:date];
        dateField.text = stringFromDate;
    }
    else{
        self.currentDict = theLevelFormObject.theNewLevelForm;
        self.excavators = [[NSMutableArray alloc] init];
        
        //prepopulate date field with current date
        NSDate *today = [[NSDate alloc] init];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterLongStyle];
        NSString *stringFromDate = [formatter stringFromDate:today];
        dateField.text = stringFromDate;
        
        // put current date into dictionary (this is important when calling other popovers
        NSDateFormatter *dictForm = [[NSDateFormatter alloc] init];
        [dictForm setDateFormat:@"yyyy'-'MM'-'dd"];
        NSString *dictDate = [dictForm stringFromDate:today];
        [self.currentDict setObject:dictDate forKey:@"date"];
    }

    // for use when calling/dismissing keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //Popover instantiation... Basically this creates the popover view somewhat programatically so that it can do stuff when its dismissed
    HDPopovers *areaContent = [self.storyboard instantiateViewControllerWithIdentifier:@"areaPopover"];
    self.areaPopover = [[UIPopoverController alloc] initWithContentViewController:areaContent];
    self.areaPopover.delegate = self;
    
    HDPopovers *excavationContent = [self.storyboard instantiateViewControllerWithIdentifier:@"excavationPopover"];
    self.excavationPopover = [[UIPopoverController alloc] initWithContentViewController:excavationContent];
    self.excavationPopover.delegate = self;
    
    HDPopovers *screenSizeContent = [self.storyboard instantiateViewControllerWithIdentifier:@"screenSizePopover"];
    self.screenSizePopover = [[UIPopoverController alloc] initWithContentViewController:screenSizeContent];
    self.screenSizePopover.delegate = self;
    
    HDPopovers *stratumContent = [self.storyboard instantiateViewControllerWithIdentifier:@"stratumPopover"];
    self.stratumPopover = [[UIPopoverController alloc] initWithContentViewController:stratumContent];
    self.stratumPopover.delegate = self;
    
    HDPopovers *dateContent = [self.storyboard instantiateViewControllerWithIdentifier:@"datePopover"];
    self.datePopover = [[UIPopoverController alloc] initWithContentViewController:dateContent];
    self.datePopover.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
//When you finish editing a text field, saves the current values on the page.
{
    if (textField == areaDescription)
        self.areaFlag = 0;
    else if (textField == excavationInterval)
        self.intervalFlag = 0;
    
    [self.currentDict setObject:stratum.text forKey:@"stratum"];
    [self.currentDict setObject:stratumLevel.text forKey:@"stratumLevel"];
    [self.currentDict setObject:digName.text forKey:@"digName"];
    [self.currentDict setObject:level.text forKey:@"level"];
    [self.currentDict setObject:totalLevels.text forKey:@"totalLevels"];
    [self.currentDict setObject:areaDescription.text forKey:@"areaDescription"];
    [self.currentDict setObject:unitEasting.text forKey:@"unitEasting"];
    [self.currentDict setObject:unitNorthing.text forKey:@"unitNorthing"];
    [self.currentDict setObject:unitSizeX.text forKey:@"unitSizeX"];
    [self.currentDict setObject:unitSizeY.text forKey:@"unitSizeY"];
    [self.currentDict setObject:verticalDatumID.text forKey:@"verticalDatumID"];
    [self.currentDict setObject:datumStringElevation.text forKey:@"datumStringElevation"];
    [self.currentDict setObject:excavationInterval.text   forKey:@"excavationInterval"];
    [self.currentDict setObject:screenSize.text forKey:@"screenSize"];

    //gets the date from the dateField and converts it into the format for the dictionary -JB
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy"];
    NSDate *date = [[NSDate alloc] init];
    date = [format dateFromString: dateField.text];

    // formating the date for the dictionary
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    [self.currentDict setObject:stringFromDate forKey:@"date"];

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
    NSString * areaText = [self.currentDict objectForKey:@"areaDescription"];
    NSString * intervalText = [self.currentDict objectForKey:@"excavationInterval"];

    if (textField == areaDescription && [areaText isEqualToString:@"OTHER"] && self.areaFlag == 1) {
        self.intervalFlag = 0;
    }
    else if (textField == excavationInterval && [intervalText isEqualToString:@"OTHER"] && self.intervalFlag == 1){
        self.intervalFlag = 0;
    }
    else if (textField == areaDescription || textField == screenSize || textField == excavationInterval || textField == stratum || textField == dateField){
        [textField resignFirstResponder];
    }
    // used by Jen's keyboard stuff
    self.activeField = textField;
}

///////////////////Excavators/////////////////////
- (IBAction)addExcavator:(id)sender
{
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
    [self.currentDict setObject:self.excavators forKey:@"excavators"];
    self.excavatorLoc += 35;
    
    excavatorsView.contentSize = CGSizeMake(280, self.excavatorLoc);
}

-(IBAction)deleteExcavator:(id)sender
{
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
            [self.currentDict setObject:self.excavators forKey:@"excavators"];
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

//////// SCROLL WINDOW ABOVE KEYBOARD /////////////
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
