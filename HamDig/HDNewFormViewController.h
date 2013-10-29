//
//  HDNewFormViewController.h
//  HamDig
//
//  Created by Sampson Reider on 10/20/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HDNewFormViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stratumTextField;
@property (copy, nonatomic) NSString *stratum; 

@property (weak, nonatomic) IBOutlet UITextField *stratumLevelTextField;
@property (copy, nonatomic) NSString *stratumLevel;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (copy, nonatomic) NSString *date;

@property (weak, nonatomic) IBOutlet UITextField *levelTextField;
@property (copy, nonatomic) NSString *level;

@property (weak, nonatomic) IBOutlet UITextField *totalOfLevelsTextField;
@property (copy, nonatomic) NSString *totalOfLevels;

@property (strong, nonatomic) IBOutlet UIPickerView *areaPickerView;

@property (strong, nonatomic) IBOutlet UITextField *areaTextField;
@property (copy, nonatomic) NSString *area;

- (IBAction)areaNumTextFieldDataEntry:(id)sender;
@property (strong, nonatomic) NSArray *areaNumArray;
@property (strong, nonatomic) NSArray *areaTypeArray;

@property (strong, nonatomic) IBOutlet UITextField *eastingTextField;
@property (strong, nonatomic) NSString *easting;

@property (strong, nonatomic) IBOutlet UITextField *northingTextField;
@property (strong, nonatomic) NSString *northing;

@property (strong, nonatomic) IBOutlet UITextField *unitSizeWidthTextField;
@property (strong, nonatomic) NSString *unitSizeWidth;

@property (strong, nonatomic) IBOutlet UITextField *unitSizeHeightTextField;
@property (strong, nonatomic) NSString *unitSizeHeight;

@property (strong, nonatomic) IBOutlet UITextField *verticalDatumIdTextField;
@property (strong, nonatomic) NSString *verticalDatumId;

@property (strong, nonatomic) IBOutlet UITextField *datumStringElevationTextField;
@property (strong, nonatomic) NSString *datumStringElevation;

@property (strong, nonatomic) IBOutlet UITextField *excavationIntervalTextField;
@property (strong, nonatomic) NSString *excavationInterval;

@property (strong, nonatomic) IBOutlet UITextField *screenSizeTextField;
@property (strong, nonatomic) NSString *screenSize;

@property (strong, nonatomic) NSMutableDictionary *dict;

- (IBAction)saveForm:(id)sender;







@end
