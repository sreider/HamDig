//
//  HDNewFormViewController.h
//  HamDig
//
//  Created by Sampson Reider on 10/20/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HDNewFormViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stratumTextField;
@property (copy, nonatomic) NSString *stratum;

@property (weak, nonatomic) IBOutlet UITextField *stratumLevelTextField;
@property (copy, nonatomic) NSString *stratumLevel;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (copy, nonatomic) NSString *date;

@property (weak, nonatomic) IBOutlet UITextField *levelTextField;
@property (copy, nonatomic) NSString *level;

@property (weak, nonatomic) IBOutlet UITextField *totalOfLevelsTextField;
@property (copy, nonatomic) NSString *totalOfLevels;

@property (weak, nonatomic) IBOutlet UITextField *areaTypeTextField;
@property (copy, nonatomic) NSString *areaType;

@property (strong, nonatomic) IBOutlet UITextField *areaNumTextField;
@property (copy, nonatomic) NSString *areaNum;

@property (strong, nonatomic) IBOutlet UIPickerView *areaNumPickerView;

- (IBAction)areaNumTextFieldDataEntry:(id)sender;
@property (strong, nonatomic) NSArray *areaNumArray;


@property (strong, nonatomic) IBOutlet UITextField *eastingTextField;
@property (copy, nonatomic) NSString *easting;

@property (strong, nonatomic) IBOutlet UITextField *northingTextField;
@property (copy, nonatomic) NSString *northing;

@property (strong, nonatomic) IBOutlet UITextView *aTextFielf;
@property (copy, nonatomic) NSString *aText;

@property (strong, nonatomic) IBOutlet UITextView *bTextField;
@property (copy, nonatomic) NSString *bText;

@property (strong, nonatomic) IBOutlet UITextView *cTextField;
@property (copy, nonatomic) NSString *cText;

@property (strong, nonatomic) NSMutableDictionary *dict;

- (IBAction)saveForm:(id)sender;


@end
