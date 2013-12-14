//
//  HDProvenienceDataViewController.h
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDProvenienceDataViewController : UIViewController <UITextFieldDelegate,  UIPopoverControllerDelegate, UIScrollViewDelegate>
{
    IBOutlet UITextField *stratum;
    IBOutlet UITextField *stratumLevel;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UITextField *level;
    IBOutlet UITextField *totalLevels;
    IBOutlet UITextField *areaDescription;
    IBOutlet UITextField *unitEasting;
    IBOutlet UITextField *unitNorthing;
    IBOutlet UITextField *unitSizeX;
    IBOutlet UITextField *unitSizeY;
    IBOutlet UITextField *verticalDatumID;
    IBOutlet UITextField *datumStringElevation;
    IBOutlet UITextField *excavationInterval;
    IBOutlet UITextField *screenSize;
    IBOutlet UIScrollView *excavatorsView;
    
    IBOutlet UITextField *dateField;
    

}
- (IBAction)addExcavator:(id)sender;
- (IBAction)saveForm:(id)sender;

@end
