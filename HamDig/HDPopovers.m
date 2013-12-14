//
//  HDPopovers.m
//  HamDig
//
//  Created by Jennifer Beckett on 10/24/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDLevelFormObject.h"
#import "HDAppDelegateProtocol.h"
#import "HDAppDelegate.h"
#import "HDPopovers.h"

@interface HDPopovers ()

@property (strong, nonatomic) NSArray *areaNumArray;
@property (strong, nonatomic) NSArray *areaTypeArray;
@property (strong, nonatomic) NSArray *screenSizeArray;
@property (strong, nonatomic) NSArray *excavationIntervalArray;

@property (strong, nonatomic) NSArray *stratumArray;
@property (strong, nonatomic) NSArray *stratumAppendArray;

@end

@implementation HDPopovers



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
	// Do any additional setup after loading the view.
    //HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.areaNumArray = [[NSArray alloc] initWithObjects: @" ", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    self.areaTypeArray = [[NSArray alloc] initWithObjects: @" ", @"Extramural", @"Housepit", @"Midden", @"--OTHER--", nil];
    self.screenSizeArray = [[NSArray alloc] initWithObjects: @" ", @"1/8 inch", @"1/4 inch", @"1/2 inch", @"2 mm", @"4 mm", @"6 mm", nil];
    self.excavationIntervalArray = [[NSArray alloc] initWithObjects: @" ", @"5 cm", @"10 cm", @"15 cm", @"--OTHER--", nil];
    
    self.stratumArray = [[NSArray alloc] initWithObjects: @" ", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", @"X", @"XI", @"XII", @"XIII", @"XIV", @"XV", @"XVI", @"XVII", @"XVIII", @"XIX", @"XX", @"XXI" @"XXII", @"XXIII", @"XXIV", @"XXV", @"XXVI", @"XXVII", @"XXVIII", @"XXIX", @"XXX", nil];
    self.stratumAppendArray = [[NSArray alloc] initWithObjects: @" ", @"- 1", @"- 2", @"- 3", @"- 4", @"- 5", @"- 6", @"- 7", @"- 8", @"- 9", nil];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == areaPicker)
        return 2;
    else if (pickerView == stratumPicker)
        return 2;
    else
        return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == areaPicker){
        if (component == 0)
            return [self.areaTypeArray count];
        else
            return [self.areaNumArray count];
    }
    else if (pickerView == stratumPicker){
        if (component == 0)
            return [self.stratumArray count];
        else
            return [self.stratumAppendArray count];
    }
    
    else if (pickerView == screenSizePicker)
        return [self.screenSizeArray count];
     
    else if (pickerView == excavationPicker)
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
    else if (pickerView == stratumPicker){
        if (component == 0)
            return [self.stratumArray objectAtIndex:row];
        else
            return [self.stratumAppendArray objectAtIndex:row];
    }

    else if (pickerView == screenSizePicker)
        return [self.screenSizeArray objectAtIndex:row];
    
    else if (pickerView == excavationPicker)
        return [self.excavationIntervalArray objectAtIndex:row];

    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    if (pickerView == areaPicker){
        if ([[self.areaTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]] isEqual: @"--OTHER--"]){
            theLevelFormObject.areaDescription = @"OTHER";
        }
       else{
            theLevelFormObject.areaDescription = [NSString stringWithFormat: @"%@ %@", [self.areaTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]],[self.areaNumArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
        }
    }
    else if (pickerView == stratumPicker){
        theLevelFormObject.stratum = [NSString stringWithFormat:@"%@ %@", [self.stratumArray objectAtIndex:[pickerView selectedRowInComponent:0]], [self.stratumAppendArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
    }
    
    else if (pickerView == screenSizePicker){
        theLevelFormObject.screenSize = [self.screenSizeArray objectAtIndex:[pickerView selectedRowInComponent:0]];
    }
    else if (pickerView == excavationPicker){
        if ([[self.excavationIntervalArray objectAtIndex:[pickerView selectedRowInComponent:0]]  isEqual: @"--OTHER--"]){
            theLevelFormObject.excavationInterval = @"OTHER";
        }
        else{
            theLevelFormObject.excavationInterval= [self.excavationIntervalArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        }
    
    }

}

- (IBAction)dateSet:(id)sender {
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd"];
    NSString *stringFromDate = [formatter stringFromDate:datePicker.date];
    theLevelFormObject.date = stringFromDate;

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
