//
//  HDNewFormViewController.m
//  HamDig
//
//  Created by Sampson Reider on 10/20/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDNewFormViewController.h"

@interface HDNewFormViewController ()

@end

@implementation HDNewFormViewController

@synthesize stratum = _stratum;
@synthesize stratumLevel = _stratumLevel;
@synthesize level = _level;
@synthesize totalOfLevels = _totalOfLevels;
@synthesize areaType = _areaType;
@synthesize areaNum = _areaNum;
@synthesize areaNumPickerView = _areaNumPickerView;

@synthesize dict = _dict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // will place this in another file and call init function here
    self.dict = [[NSMutableDictionary alloc] initWithCapacity:100];
    //initialize keys for dictionary
    
    // provenience data
    [self.dict setObject:@"test" forKey:@"stratum"];
    [self.dict setObject:@"test" forKey:@"stratumLevel"];
    [self.dict setObject:@"test" forKey:@"level"];
    [self.dict setObject:@"test" forKey:@"totalOfLevels"];
    [self.dict setObject:@"test" forKey:@"areaType"];
    [self.dict setObject:@"test" forKey:@"areaNum"];
    [self.dict setObject:@"test" forKey:@"easting"];
    [self.dict setObject:@"test" forKey:@"northing"];
    // can have multiple excavators
    [self.dict setObject:@"test" forKey:@"excavator(s)"];
    [self.dict setObject:@"test" forKey:@"date"];
    [self.dict setObject:@"test" forKey:@"verticalDatumID"];
    [self.dict setObject:@"test" forKey:@"datumStringElevation"];
    [self.dict setObject:@"test" forKey:@"excavationInterval"];
    [self.dict setObject:@"test" forKey:@"screenSize"];
    
    // map/place drawging
    [self.dict setObject:@"test" forKey:@"upperLeftTopDepth"];
    [self.dict setObject:@"test" forKey:@"upperLeftBottomDepth"];
    [self.dict setObject:@"test" forKey:@"upperRightTopDepth"];
    [self.dict setObject:@"test" forKey:@"upperRightBottomDepth"];
    [self.dict setObject:@"test" forKey:@"bottomLeftTopDepth"];
    [self.dict setObject:@"test" forKey:@"bottomLeftBottomDepth"];
    [self.dict setObject:@"test" forKey:@"bottomRightTopDepth"];
    [self.dict setObject:@"test" forKey:@"bottomRightBottomDepth"];
    [self.dict setObject:@"test" forKey:@"centerTopDepth"];
    [self.dict setObject:@"test" forKey:@"centerBottomDepth"];
    // legend values? scale values?
    
    // recovered cultural materials
    // add new values when user wants? there is no fixed number of artifacts found
    // A. Artifacts
    [self.dict setObject:@"test" forKey:@"spec#"];
    [self.dict setObject:@"test" forKey:@"artifactType"];
    [self.dict setObject:@"test" forKey:@"Esf3DProvenience"];
    [self.dict setObject:@"test" forKey:@"Nsf3DProvenience"];
    [self.dict setObject:@"test" forKey:@"Dsf3DProvenience"];
    // B. Associated Features
    [self.dict setObject:@"test" forKey:@"feature#"];
    [self.dict setObject:@"test" forKey:@"type"];
    // C. Environmental Samples
    /* same value as A?
    [self.dict setObject:@"test" forKey:@"spec#"];
    [self.dict setObject:@"test" forKey:@"Esf3DProvenience"];
    [self.dict setObject:@"test" forKey:@"Nsf3DProvenience"];
    [self.dict setObject:@"test" forKey:@"Dsf3DProvenience"]; */
    
    // narrative
    [self.dict setObject:@"test" forKey:@"aText"];
    [self.dict setObject:@"test" forKey:@"bText"];
    [self.dict setObject:@"test" forKey:@"cText"];
    
    // TA check
    [self.dict setObject:@"test" forKey:@"checkedBy"];
    [self.dict setObject:@"test" forKey:@"checkDate"];
    
    self.areaNumArray = [[NSArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == self.stratumTextField) {

        [theTextField resignFirstResponder];
        // Closes the keyboard when user hits return
    }
    else if (theTextField == self.stratumLevelTextField) {
        //EXAMPLE USE OF DICTIONARY
        // save user text
        //self.stratum = self.stratumLevelTextField.text;
        // place value in dictionary corresponding to key: stratum
        //[self.dict setObject: self.stratum forKey:@"stratum"];
        // display value in the stratum field
        //self.stratumTextField.text = [self.dict objectForKey:@"stratum"];
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.levelTextField) {
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.totalOfLevelsTextField) {
        //self.totalOfLevelsTextField.text = [self.dict objectForKey:@"stratumLevel"];
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.areaTypeTextField) {
        self.totalOfLevelsTextField.text = [self.dict objectForKey:@"totalOfLevels"];
        self.levelTextField.text = [self.dict objectForKey:@"level"];
        self.stratumLevelTextField.text = [self.dict objectForKey:@"stratumLevel"];
        self.stratumTextField.text = [self.dict objectForKey:@"stratum"];
        [theTextField resignFirstResponder];
    }

    return YES;
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 6;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.areaNumArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.areaNumTextField.text = [self.areaNumArray objectAtIndex:row];
    //[self.areaNumTextField resignFirstResponder];
    self.areaNumPickerView.hidden = YES;
    self.areaNumTextField.selected = NO;
    
}
- (IBAction)areaNumTextFieldDataEntry:(id)sender {
    
    self.areaNumPickerView.hidden = NO;
    [self.areaNumTextField endEditing:YES];
    

}


- (IBAction)saveForm:(id)sender {
    // save user text fields
    self.stratum = self.stratumTextField.text;
    self.stratumLevel = self.stratumLevelTextField.text;
    self.level = self.levelTextField.text;
    self.totalOfLevels = self.totalOfLevelsTextField.text;
    
    // place value in dictionary corresponding to key: stratum
    [self.dict setObject: self.stratum forKey:@"stratum"];
    [self.dict setObject: self.stratumLevel forKey:@"stratumLevel"];
    [self.dict setObject: self.level forKey:@"level"];
    [self.dict setObject: self.totalOfLevels forKey:@"totalOfLevels"];
}








@end

