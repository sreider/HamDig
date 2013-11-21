//
//  HDAppDelegate.h
//  HamDig
//
//  Created by Sampson Reider on 10/6/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDAppDelegateProtocol.h"
#import "HDNarrativeViewController.h"
#import "HDCulturalMaterialsViewController.h"
#import "HDPlanDrawingViewController.h"

@class HDLevelFormObject;


extern NSMutableArray *allForms;

@interface HDAppDelegate : NSObject <UIApplicationDelegate, HDAppDelegateProtocol>
{

    //NSMutableArray *allForms;
    UIWindow *window;
    UINavigationController *navigationController;
	HDLevelFormObject* theLevelFormObject;
	IBOutlet HDNarrativeViewController* theNarrativeViewController;
    IBOutlet HDCulturalMaterialsViewController* theCulturalMaterialsViewController;
    IBOutlet HDPlanDrawingViewController* thePlanDrawingViewController;

}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) HDLevelFormObject* theLevelFormObject;
@property (nonatomic, retain) IBOutlet HDNarrativeViewController* theNarrativeViewController;
@property (nonatomic, retain) IBOutlet HDCulturalMaterialsViewController* theCulturalMaterialsViewController;
@property (nonatomic, retain) IBOutlet HDPlanDrawingViewController* thePlanDrawingController;

@property BOOL currentlyEditing;
@property int currentDictIndex;

@property (nonatomic,readwrite) NSMutableArray* allForms;

@end
