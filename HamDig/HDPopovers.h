//
//  HDPopovers.h
//  HamDig
//
//  Created by Jennifer Beckett on 10/24/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDPopovers : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UIPickerView *areaPicker;
    IBOutlet UIPickerView *excavationPicker;
    IBOutlet UIPickerView *screenSizePicker;
    
    IBOutlet UIPickerView *stratumPicker;
}
@end
