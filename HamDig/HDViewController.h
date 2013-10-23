//
//  HDViewController.h
//  HamDig
//
//  Created by Sampson Reider on 10/20/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HDViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stratumTextField;
@property (copy, nonatomic) NSString *stratum;

@property (weak, nonatomic) IBOutlet UITextField *stratumLevelTextField;
@property (copy, nonatomic) NSString *stratumLevel;

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

@property (strong, nonatomic) NSMutableDictionary *dict;



@end
