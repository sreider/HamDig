//
//  HDViewController.m
//  HamDig
//
//  Created by Sampson Reider on 10/20/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDViewController.h"
#import "HDPopovers.h"

@interface HDViewController ()

@property (nonatomic, strong) UIPopoverController *barButtonItemPopover;

@property (nonatomic, strong) UIPopoverController *detailViewPopover;
@property (nonatomic, strong) id lastTappedButton;

@property (nonatomic, strong) UIPopoverController *masterPopoverController;


@end

@implementation HDViewController

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
    self.dict = [[NSMutableDictionary alloc] initWithCapacity:20];
    //initialize keys for dictionary
    [self.dict setObject:@"test" forKey:@"stratum"];
    [self.dict setObject:@"test" forKey:@"stratumLevel"];
    [self.dict setObject:@"test" forKey:@"level"];
    [self.dict setObject:@"test" forKey:@"totalOfLevels"];
    
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
        self.stratum = self.stratumLevelTextField.text;
        // place value in dictionary corresponding to key: stratum
        [self.dict setObject: self.stratum forKey:@"stratum"];
        // display value in the stratum field
        self.stratumTextField.text = [self.dict objectForKey:@"stratum"];
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.levelTextField) {
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.totalOfLevelsTextField) {
        self.totalOfLevelsTextField.text = [self.dict objectForKey:@"stratumLevel"];
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.areaTypeTextField) {
        
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







@end
