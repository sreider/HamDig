//
//  HDPopovers.h
//  HamDig
//
//  Created by Jennifer Beckett on 10/24/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDPopovers : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{

    IBOutlet UIPickerView *areaPicker;
    IBOutlet UIPickerView *excavationIntervalPicker;
    IBOutlet UIPickerView *screenSizePicker;
}
@end
