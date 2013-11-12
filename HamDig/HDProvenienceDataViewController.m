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

@interface HDProvenienceDataViewController ()
@property (nonatomic, strong) UIPopoverController *barButtonItemPopover;
@property (nonatomic, strong) UIPopoverController *detailViewPopover;
@property (nonatomic, strong) id lastTappedButton;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;

@property (strong, nonatomic) NSArray *areaNumArray;
@property (strong, nonatomic) NSArray *areaTypeArray;
@end

@implementation HDProvenienceDataViewController


- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}

- (IBAction)addExcavator:(UIButton *)sender {
    //Method to add an excavator
    //Must implement.
}

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
}

- (IBAction)showPopover:(id)sender
{
    UIButton *tappedButton = (UIButton *)sender;
    [self.detailViewPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.areaNumArray = [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", nil];
    self.areaTypeArray = [[NSArray alloc] initWithObjects: @"Extramural", @"Housepit", @"Midden", nil];
    
    
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    theLevelFormObject.theNewLevelForm = [[NSMutableDictionary alloc] init];
    
    NSLog(@"NewLevelForm Dictionary Initialized");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
//When you finish editing a text field, saves the current values on the page.
{
    //shouldn't the new object be created when we click "New Form" on the
    // main page?
    
    // I think this is just a pointer to theLevelFormObject -SR
    
    
	HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    theLevelFormObject.stratum = stratum.text;
    theLevelFormObject.stratumLevel = stratumLevel.text;
    theLevelFormObject.date = (NSString*)datePicker.date;  //<<<<<<----- MIGHT BE WRONG TYPE
    theLevelFormObject.level = level.text;
    theLevelFormObject.totalLevels = totalLevels.text;
    theLevelFormObject.areaDescription = areaDescription.text;
    theLevelFormObject.unitEasting = unitEasting.text;
    theLevelFormObject.unitNorthing = unitNorthing.text;
    theLevelFormObject.unitSizeX = unitSizeX.text;
    theLevelFormObject.unitSizeY = unitSizeY.text;
    theLevelFormObject.verticalDatumID = verticalDatumID.text;
    theLevelFormObject.datumStringElevation = datumStringElevation.text;
    theLevelFormObject.excavationInterval = excavationInterval.text;
    theLevelFormObject.screenSize = screenSize.text;
    
    
    // Fill dictionary for each form...
    
    // should this be done in our void save method?
    // I don't think so. I think our void save method should be just for
    // saving theNewLevelForm to the array -SR
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    //none of this should be here, I was just messing around and testing things. I'll come back and change this after class!
    
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    theLevelFormObject.stratum = stratum.text;
    //[theLevelFormObject.theNewLevelForm setObject:stratum.text forKey:@"stratum"];
    //[theLevelFormObject save];
    [theTextField resignFirstResponder];
    return TRUE;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == areaDescription){
        [textField resignFirstResponder];
    }
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
    return 6;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == areaPicker){
        if (component == 0)
            return [self.areaTypeArray objectAtIndex:row];
        else
            return [self.areaNumArray objectAtIndex:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == areaPicker){
        areaDescription.text = [NSString stringWithFormat: @"%@%@", [self.areaTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]],[self.areaNumArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
    }
 
}



@end
