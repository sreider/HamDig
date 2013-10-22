//
//  HDViewController.h
//  HamDig
//
//  Created by Sampson Reider on 10/20/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HDViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stratumTextField;
@property (copy, nonatomic) NSString *stratum;

@property (weak, nonatomic) IBOutlet UITextField *stratumLevelTextField;
@property (copy, nonatomic) NSString *stratumLevel;

@property (weak, nonatomic) IBOutlet UITextField *levelTextField;
@property (copy, nonatomic) NSString *level;

@property (weak, nonatomic) IBOutlet UITextField *totalOfLevelsTextField;
@property (copy, nonatomic) NSString *totalOfLevels;


@end
