//
//  HDViewControllerSavingAppDelegate.m
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

// what does this form and it's .h do?


#import "HDViewControllerSavingAppDelegate.h"
#import "HDProvenienceDataViewController.h"
#import "HDAppDelegateProtocol.h"
#import "HDLevelFormObject.h"

@implementation HDViewControllerSavingAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize theLevelFormObject;
@synthesize theNarrativeViewController;
@synthesize theCulturalMaterialsViewController;
@synthesize thePlanDrawingViewController;

-(void) pushSecondView;
{
	[navigationController pushViewController: theNarrativeViewController animated:TRUE];
    [navigationController pushViewController: theCulturalMaterialsViewController animated:TRUE];
    [navigationController pushViewController: thePlanDrawingViewController animated:TRUE];
	
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (id) init;
{
	self.theLevelFormObject = [[HDLevelFormObject alloc] init];
	return [super init];
}



- (void)dealloc
{
	
	self.theLevelFormObject = nil;
	self.theNarrativeViewController = nil;
    self.theCulturalMaterialsViewController = nil;
    self.thePlanDrawingViewController = nil;

}



@end
