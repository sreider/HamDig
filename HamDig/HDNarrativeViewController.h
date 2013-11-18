//
//  HDNarrativeViewController.h
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDNarrativeViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UITextView *excavationDescription;
    IBOutlet UITextView *sedimentDescription;
    IBOutlet UITextView *otherNarrative;
//    IBOutlet UITextView *activeField;
}


- (IBAction)saveAction:(id)sender;

@end
