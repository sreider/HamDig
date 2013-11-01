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
    
    // This will work, I think...but it needs to get called by the button press. 
    
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
    
    [theLevelFormObject.theNewLevelForm setObject:stratum.text forKey:@"stratum"];
    [theLevelFormObject.theNewLevelForm setObject:stratumLevel.text forKey:@"stratumLevel"];
    [theLevelFormObject.theNewLevelForm setObject:level.text forKey:@"level"];

    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
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
