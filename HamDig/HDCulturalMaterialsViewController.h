//
//  HDCulturalMaterialsViewController.h
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDCulturalMaterialsViewController : UIViewController<UITextFieldDelegate, UIPopoverControllerDelegate>
{
    
    IBOutlet UIButton *artifactsButton;
    IBOutlet UIButton *featuresButton;
    IBOutlet UIButton *samplesButton;
}


- (IBAction)addArtifact:(id)sender;
- (IBAction)addFeature:(id)sender;
- (IBAction)addSample:(id)sender;


@end
