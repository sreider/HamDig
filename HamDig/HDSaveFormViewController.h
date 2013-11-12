//
//  HDSaveFormViewController.h
//  HamDig
//
//  Created by Sampson Reider on 11/12/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDSaveFormViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *formTitle;
}


- (IBAction)save:(UIButton *)sender;

//- (IBAction)save;
//- (IBAction)addExcavator:(UIButton *)sender;


//- (IBAction)saveForm:(id)sender;

@end



