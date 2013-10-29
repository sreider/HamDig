//
//  HDNewFormViewController.m
//  HamDig
//
//  Created by Sampson Reider on 10/20/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDNewFormViewController.h"
#import "HDPopovers.h"

@interface HDNewFormViewController ()

@property (nonatomic, strong) UIPopoverController *barButtonItemPopover;
@property (nonatomic, strong) UIPopoverController *detailViewPopover;
@property (nonatomic, strong) id lastTappedButton;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;

@end

@implementation HDNewFormViewController

@synthesize stratum = _stratum;

@synthesize stratumLevel = _stratumLevel;
@synthesize level = _level;
@synthesize totalOfLevels = _totalOfLevels;
@synthesize area = _area;
@synthesize areaPickerView = _areaPickerView;
@synthesize datePicker = _datePicker;
@synthesize date = _date;
@synthesize eastingTextField = _eastingTextField;
@synthesize easting = _easting;
@synthesize northingTextField = _northingTextField;
@synthesize northing = _northing;
@synthesize unitSizeWidthTextField = _unitSizeWidthTextField;
@synthesize unitSizeWidth = _unitSizeWidth;
@synthesize unitSizeHeightTextField = _unitSizeHeightTextField;
@synthesize unitSizeHeight = _unitSizeHeight;
@synthesize verticalDatumIdTextField = _verticalDatumIdTextField;
@synthesize verticalDatumId = _verticalDatumId;
@synthesize datumStringElevationTextField = _datumStringElevationTextField;
@synthesize datumStringElevation = _datumStringElevation;
@synthesize excavationIntervalTextField = _excavationIntervalTextField;
@synthesize excavationInterval = _excavationInterval;
@synthesize screenSizeTextField = _screenSizeTextField;
@synthesize screenSize = _screenSize;

// narrative
/*@synthesize bTextField = _bTextField;
 @synthesize bText = _bText;
 @synthesize cTextField = _cTextField;
 @synthesize cText = _cText;
 */
@synthesize dict = _dict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//popover controlls... lets see if this works -Jen
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
    
    // Do any additional setup after loading the view.
    
    //create dictionary. Don't need to set the amount of values but I just did this for testing
    // this should happen when the user clicks "New Form", not here... but again just wanted to test
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
    [self.dict setObject:@"test" forKey:@"unitSizeWidth"];
    [self.dict setObject:@"test" forKey:@"unitSizeHeight"];
    // can have multiple excavators
    [self.dict setObject:@"test" forKey:@"excavator(s)"];
    [self.dict setObject:@"test" forKey:@"date"];
    [self.dict setObject:@"test" forKey:@"verticalDatumId"];
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
    self.areaTypeArray = [[NSArray alloc] initWithObjects: @"Extramural", @"Housepit", @"Midden", nil];
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
    else if (theTextField == self.areaTextField) {
        
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.eastingTextField){
        /* THANK YOU for not deleting and just commenting out. This won't be here in the end. It's only for testing if the values are being saved properly. I'll comment out before each push/commit.
         self.totalOfLevelsTextField.text = [self.dict objectForKey:@"totalOfLevels"];
        self.levelTextField.text = [self.dict objectForKey:@"level"];
        self.stratumLevelTextField.text = [self.dict objectForKey:@"stratumLevel"];
        self.stratumTextField.text = [self.dict objectForKey:@"date"];
        self.unitSizeHeightTextField.text = [self.dict objectForKey:@"unitSizeWidth"]; */
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.northingTextField){
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.unitSizeWidthTextField){
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.unitSizeHeightTextField){
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.verticalDatumIdTextField){
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.datumStringElevationTextField){
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.excavationIntervalTextField){
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.screenSizeTextField){
        [theTextField resignFirstResponder];
    }

    return YES;
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.areaPickerView)
        return 2;
    else
        return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.areaPickerView){
        if (component == 0)
            return [self.areaTypeArray count];
        else
           return [self.areaNumArray count];
    }
    return 6;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.areaPickerView){
        if (component == 0)
            return [self.areaTypeArray objectAtIndex:row];
        else
            return [self.areaNumArray objectAtIndex:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Needs to allow for both choices in one picker.  
    self.areaTextField.text = [NSString stringWithFormat: @"%@, %@", [self.areaTypeArray objectAtIndex:[pickerView selectedRowInComponent:0]],[self.areaNumArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
    //[self.areaNumTextField resignFirstResponder];
    self.areaPickerView.hidden = YES;
    self.areaTextField.selected = NO;
    
}
- (IBAction)areaNumTextFieldDataEntry:(id)sender {
    
    self.areaPickerView.hidden = NO;
    [self.areaTextField endEditing:YES];
    

}




- (IBAction)saveForm:(id)sender {
    // save user text fields
    
    // provenience data
    _stratum = _stratumTextField.text;
    _stratumLevel = _stratumLevelTextField.text;
    _level = _levelTextField.text;
    _totalOfLevels = _totalOfLevelsTextField.text;
    _area = _areaTextField.text;
    _date = _datePicker.date.description;
    _easting = _eastingTextField.text;
    _northing = _northingTextField.text;
    _unitSizeWidth = _unitSizeWidthTextField.text;
    _unitSizeHeight = _unitSizeHeightTextField.text;
    _verticalDatumId  = _verticalDatumIdTextField.text;
    _datumStringElevation = _datumStringElevationTextField.text;
    _excavationInterval = _excavationIntervalTextField.text;
    _screenSize = _screenSizeTextField.text;
    
    
    
    // narrative
    //_bText = _bTextField.text;
    
    
    // place value in dictionary corresponding to key: stratum
    
    // provenience data
    [_dict setObject: _stratum forKey:@"stratum"];
    [_dict setObject: _stratumLevel forKey:@"stratumLevel"];
    [_dict setObject: _level forKey:@"level"];
    [_dict setObject: _totalOfLevels forKey:@"totalOfLevels"];
    [_dict setObject: _area forKey:@"area"];
    [_dict setObject:_date forKey:@"date"];
    [_dict setObject:_easting forKey:@"easting"];
    [_dict setObject:_northing forKey:@"northing"];
    [_dict setObject:_unitSizeWidth forKey:@"unitSizeWidth"];
    [_dict setObject:_unitSizeHeight forKey:@"unitSizeHeight"];
    [_dict setObject:_verticalDatumId forKey:@"verticalDatumId"];
    [_dict setObject:_datumStringElevation forKey:@"datumStringElevation"];
    [_dict setObject:_excavationInterval forKey:@"excavationInterval"];
    [_dict setObject:_screenSize forKey:@"screenSize"];
    // narrative
    //[_dict setObject:_bText forKey:@"bText"];


}










@end
