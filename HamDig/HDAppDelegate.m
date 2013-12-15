//
//  HDAppDelegate.m
//  HamDig
//
//  Created by Sampson Reider on 10/6/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDAppDelegate.h"
#import "HDProvenienceDataViewController.h"
#import "HDAppDelegateProtocol.h"
#import "HDLevelFormObject.h"


NSMutableArray *allForms;


//this is now our global flag to check whether the user is currently editing a form
// or not.
// Turned on: when the user clicks a "Click to edit" button on the Edit Forms page
// Turned off: when the user goes back to the main menu (when the Main Menu page loads)
// Used for: only prepopulating the fields of forms when flag is on
// -ES
BOOL currentlyEditing;

// This is the global variable for the index that keeps track of which form the user
// is currently editing. It is one less than the tag of the button corresponding to the
// form displayed on Edit Forms
// -ES
int currentDictIndex;

// to keep a copy if user wants to go back to old version without saving   -ES
NSMutableDictionary * dictCopy;

@implementation HDAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize theLevelFormObject;
@synthesize theNarrativeViewController;
@synthesize theCulturalMaterialsViewController;
@synthesize thePlanDrawingController;
@synthesize allForms;

-(void) pushOtherViews;
{
	[navigationController pushViewController: theNarrativeViewController animated:TRUE];
    [navigationController pushViewController: theCulturalMaterialsViewController animated:TRUE];
    [navigationController pushViewController: thePlanDrawingViewController animated:TRUE];
}

-(BOOL) getSavedState;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"Documents Directory: %@", documentsDirectory);
    
    NSString *stateFile = [documentsDirectory stringByAppendingPathComponent:@"HamDigSaveState.txt"];
    
    NSError *error;

    NSData *fileContents = [NSData dataWithContentsOfFile:stateFile];
    
    // If there isn't a saved state, leave allForms empty.
    if (nil == fileContents) {
        return FALSE;
    }

    NSMutableArray *newAllForms = [NSJSONSerialization JSONObjectWithData:fileContents options:kNilOptions error:&error];
    
    NSLog(@"%@", newAllForms);
    
    allForms = [newAllForms mutableCopy];
    NSLog(@"%hhd", [allForms isKindOfClass:[NSMutableArray class]]);
    NSLog(@"%i", allForms.count);
    
    return TRUE;

}


-(void) saveAppState;
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allForms
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSLog(@"Creating file...");

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"Documents Directory: %@", documentsDirectory);
    
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"HamDigSaveState.txt"];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
    
        BOOL ok = [jsonString writeToFile:appFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
        if (!ok) {        // an error occurrer
            NSLog(@"Error writing file at %@\n%@", appFile, [error localizedFailureReason]);
        }
        else {
            NSLog(@"Successfully saved state");
        }
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    
    allForms = [[NSMutableArray alloc] init];
 //   [self getSavedState];
    return YES;
}

- (id) init;
{
	self.theLevelFormObject = [[HDLevelFormObject alloc] init];
	return [super init];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
 //   [self saveAppState];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  //  [self saveAppState];
}

@end
