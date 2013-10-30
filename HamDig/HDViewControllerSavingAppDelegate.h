//
//  HDViewControllerSavingAppDelegate.h
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HDAppDelegateProtocol.h"
#import "HDNarrativeViewController.h"
#import "HDCulturalMaterialsViewController.h"
#import "HDPlanDrawingViewController.h"

@class HDLevelFormObject;

@interface HDViewControllerSavingAppDelegate : NSObject <UIApplicationDelegate, HDAppDelegateProtocol>
{
    
    UINavigationController *navigationController;
    HDLevelFormObject* theLevelFormObject;
    IBOutlet HDNarrativeViewController* theNarrativeViewController;
    IBOutlet HDCulturalMaterialsViewController* theCulturalMaterialsViewController;
    IBOutlet HDPlanDrawingViewController* thePlanDrawingViewController;
}


@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) HDLevelFormObject* theLevelFormObject;
@property (nonatomic, retain) IBOutlet HDNarrativeViewController* theNarrativeViewController;
@property (nonatomic, retain) IBOutlet HDCulturalMaterialsViewController* theCulturalMaterialsViewController;
@property (nonatomic, retain) IBOutlet HDPlanDrawingViewController* thePlanDrawingViewController;

@end
