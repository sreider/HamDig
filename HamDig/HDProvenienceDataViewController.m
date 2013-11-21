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
@property (nonatomic, strong) UIPopoverController *barButtonItemPopover;
@property (nonatomic, strong) UIPopoverController *detailViewPopover;
@property (nonatomic, strong) id lastTappedButton;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;

@property (strong, nonatomic) NSArray *areaNumArray;
@property (strong, nonatomic) NSArray *areaTypeArray;
@property (strong, nonatomic) NSArray *screenSizeArray;
@property (strong, nonatomic) NSArray *excavationIntervalArray;

// controll scroll view for moving view up when keyboard is called
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextField *activeField;

@end

@implementation HDProvenienceDataViewController


- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}




// don't think we need this action anymore. Saving happens in save popover window
// can we get rid of this?                  -ES
// Most likely. I just put this in as a reminder to save. -Leah
- (IBAction)saveForm:(id)sender {
    
    
    // saves the current state of the form in the list of all forms.
    //Must implement....
    
    /* I think this should be moved to a new view controller file for the
     real save button that shows up on the popover. The save buttons on the
     provenience form and others just opens up the popover. Shouldn't the real
     work be done in that popover? */
    
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    [theLevelFormObject save];
    
}

//Popover stuff from Jen
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.lastTappedButton = nil;
    
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    areaDescription.text = theLevelFormObject.areaDescription;
    screenSize.text = theLevelFormObject.screenSize;
    excavationInterval.text = theLevelFormObject.excavationInterval;
    
    NSLog(@"Dismissed Popover");

}


- (IBAction)showPopover:(id)sender
{
    UIButton *tappedButton = (UIButton *)sender;
    [self.detailViewPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;
 
    if (sender == addExcavator){
        [newExcavator becomeFirstResponder];
    }
}


- (void)viewDidLoad
{
    // I know this is a mess but I'll clean this up later!! This was just a rushed example          -ES
    
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentlyEditing) {
        NSLog(@"Editing flag is on");
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary *currentDict = [appDelegate.allForms objectAtIndex:i];
        // save the form's title
        NSString *currentTitle = [currentDict objectForKey:@"formTitle"];
        NSLog(@"Editing form with");
        NSLog(currentTitle);
        
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
    }
    
    
    [super viewDidLoad];
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    self.areaNumArray = [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", nil];
    self.areaTypeArray = [[NSArray alloc] initWithObjects: @"Extramural", @"Housepit", @"Midden", @"--OTHER--", nil];
    self.screenSizeArray = [[NSArray alloc] initWithObjects: @"1/8 inch", @"1/4 inch", @"1/2 inch", @"2 mm", @"4 mm", @"6 mm", nil];
    self.excavationIntervalArray = [[NSArray alloc] initWithObjects:@"5 cm", @"10 cm", @"15 cm", @"--OTHER--", nil];
    
    for (int i=0; i<[theLevelFormObject.excavators count]; i++) {
        UILabel *newExc = [[UILabel alloc] initWithFrame:CGRectMake(10, i * 20, 200, 40)];
        [newExc setText:[theLevelFormObject.excavators objectAtIndex:i]];
        [excavatorsView addSubview:newExc];
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
//When you finish editing a text field, saves the current values on the page.
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    if (textField == newExcavator){
        if(![newExcavator.text isEqualToString:@""]){
            NSLog(@"%@", newExcavator.text);
            [theLevelFormObject.excavators addObject:newExcavator.text];
            UILabel *newExc = [[UILabel alloc] initWithFrame:CGRectMake(10, [theLevelFormObject.excavators count] * 20 - 20, 200, 40)];
            [newExc setText:[theLevelFormObject.excavators lastObject]];
            [self.view addSubview:newExc];
            
            [theLevelFormObject.theNewLevelForm setObject:theLevelFormObject.excavators forKey:@"excavators"];
            NSLog(@"Num excavators %i", [theLevelFormObject.excavators count]);
            [newExcavator setText:@""];
        }
    }
    
    else{

    
    theLevelFormObject.stratum = stratum.text;
    theLevelFormObject.stratumLevel = stratumLevel.text;
    theLevelFormObject.date = (NSString*)datePicker.date;  //<<<<<<----- MIGHT BE WRONG TYPE
    theLevelFormObject.level = level.text;
    theLevelFormObject.totalLevels = totalLevels.text;
    theLevelFormObject.unitEasting = unitEasting.text;
    theLevelFormObject.unitNorthing = unitNorthing.text;
    theLevelFormObject.unitSizeX = unitSizeX.text;
    theLevelFormObject.unitSizeY = unitSizeY.text;
    theLevelFormObject.verticalDatumID = verticalDatumID.text;
    theLevelFormObject.datumStringElevation = datumStringElevation.text;
    
    areaDescription.text = theLevelFormObject.areaDescription;
    screenSize.text = theLevelFormObject.screenSize;
    excavationInterval.text = theLevelFormObject.excavationInterval;
    
    // Fill dictionary for each form...
    
    // should this be done in our void save method?
    // I don't think so. I think our void save method should be just for
    // saving theNewLevelForm to the array -SR
    
    // array is now being save from the save button, not void save
    // do we still need the void save method for anything?      -ES
    
    // Provenience Data
    [theLevelFormObject.theNewLevelForm setObject:stratum.text forKey:@"stratum"];
    [theLevelFormObject.theNewLevelForm setObject:stratumLevel.text forKey:@"stratumLevel"];
    [theLevelFormObject.theNewLevelForm setObject:(NSString*)datePicker.date forKey:@"date"];
    [theLevelFormObject.theNewLevelForm setObject:level.text forKey:@"level"];
    [theLevelFormObject.theNewLevelForm setObject:totalLevels.text forKey:@"totalLevels"];
    [theLevelFormObject.theNewLevelForm setObject:areaDescription.text forKey:@"areaDescription"];
    [theLevelFormObject.theNewLevelForm setObject:unitEasting.text forKey:@"unitEasting"];
    [theLevelFormObject.theNewLevelForm setObject:unitNorthing.text forKey:@"unitNorthing"];
    [theLevelFormObject.theNewLevelForm setObject:unitSizeX.text forKey:@"unitSizeX"];
    [theLevelFormObject.theNewLevelForm setObject:unitSizeY.text forKey:@"unitSizeY"];
    [theLevelFormObject.theNewLevelForm setObject:verticalDatumID.text forKey:@"verticalDatumID"];
    [theLevelFormObject.theNewLevelForm setObject:datumStringElevation.text forKey:@"datumStringElevation"];
    [theLevelFormObject.theNewLevelForm setObject:excavationInterval.text forKey:@"excavationInterval"];
    [theLevelFormObject.theNewLevelForm setObject:screenSize.text forKey:@"screenSize"];

    
    NSLog(@"Stratum: %@", [theLevelFormObject.theNewLevelForm objectForKey:@"stratum"]);
    }
    // used by Jen's keyboard stuff
    self.activeField = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
        
    [theTextField resignFirstResponder];
    return TRUE;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == areaDescription || textField == screenSize || textField == excavationInterval){
        [textField resignFirstResponder];
    }
    // used by Jen's keyboard stuff
    self.activeField = textField;
    
}

//// returns the number of columns to display in picker view.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == areaPicker)
        return 2;
    else
        return 1;
}

//// returns the # of rows in each component of a picker view.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == areaPicker){
        if (component == 0)
            return [self.areaTypeArray count];
        else
            return [self.areaNumArray count];
    }
    else if (pickerView == screenSizePicker)
        return [self.screenSizeArray count];
    
    else if (pickerView == excavationIntervalPicker)
        return [self.excavationIntervalArray count];
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == areaPicker){
        if (component == 0)
            return [self.areaTypeArray objectAtIndex:row];
        else
            return [self.areaNumArray objectAtIndex:row];
    }
    
    else if (pickerView == screenSizePicker)
        return [self.screenSizeArray objectAtIndex:row];
    
    else if (pickerView == excavationIntervalPicker)
        return [self.excavationIntervalArray objectAtIndex:row];
    
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    if (pickerView == areaPicker){
        if ([[self.areaTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]]  isEqual: @"--OTHER--"]){
            areaDescription.text = @"OTHER";
        }
        else{
            theLevelFormObject.areaDescription = [NSString stringWithFormat: @"%@ %@", [self.areaTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]],[self.areaNumArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
        }
    }
    else if (pickerView == screenSizePicker){
        theLevelFormObject.screenSize = [self.screenSizeArray objectAtIndex:[pickerView selectedRowInComponent:0]];
    }
    else if (pickerView == excavationIntervalPicker){
        if ([[self.excavationIntervalArray objectAtIndex:[pickerView selectedRowInComponent:0]]  isEqual: @"--OTHER--"]){
            excavationInterval.text = @"OTHER";
        }
        else{
            theLevelFormObject.excavationInterval= [self.excavationIntervalArray objectAtIndex:[pickerView selectedRowInComponent:0]];
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
