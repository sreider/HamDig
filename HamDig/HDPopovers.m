//
//  HDPopovers.m
//  HamDig
//
//  Created by Jennifer Beckett on 10/24/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDLevelFormObject.h"
#import "HDAppDelegateProtocol.h"
#import "HDPopovers.h"
#import "HDAppDelegate.h"

@interface HDPopovers ()


@property (strong, nonatomic) NSArray *areaNumArray;
@property (strong, nonatomic) NSArray *areaTypeArray;
@property (strong, nonatomic) NSArray *screenSizeArray;
@property (strong, nonatomic) NSArray *excavationIntervalArray;

@end

@implementation HDPopovers


/*
- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.areaNumArray = [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", nil];
    self.areaTypeArray = [[NSArray alloc] initWithObjects: @"Extramural", @"Housepit", @"Midden", @"--OTHER--", nil];
    self.screenSizeArray = [[NSArray alloc] initWithObjects: @"1/8 inch", @"1/4 inch", @"1/2 inch", @"2 mm", @"4 mm", @"6 mm", nil];
    self.excavationIntervalArray = [[NSArray alloc] initWithObjects:@"5 cm", @"10 cm", @"15 cm", @"--OTHER--", nil];

}
/*

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
 */
/*
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    if (pickerView == areaPicker){
        if ([[self.areaTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]]  isEqual: @"--OTHER--"]){
            //areaDescription.text = @"OTHER";
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
            //excavationInterval.text = @"OTHER";
        }
        else{
            theLevelFormObject.excavationInterval= [self.excavationIntervalArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        }
    }
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
