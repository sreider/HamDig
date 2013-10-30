//
//  HDCulturalMaterialsViewController.m
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDCulturalMaterialsViewController.h"
#import "HDLevelFormObject.h"
#import "HDAppDelegateProtocol.h"
#import "HDPopovers.h"

@interface HDCulturalMaterialsViewController ()

@property (nonatomic, strong) UIPopoverController *barButtonItemPopover;
@property (nonatomic, strong) UIPopoverController *detailViewPopover;
@property (nonatomic, strong) id lastTappedButton;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;

@end

@implementation HDCulturalMaterialsViewController

//Popover stuff from Jen
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.lastTappedButton = nil;
}

- (IBAction)showPopover:(id)sender
{
    UIButton *tappedButton = (UIButton *)sender;
    [self.detailViewPopover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.lastTappedButton = sender;
}

- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
