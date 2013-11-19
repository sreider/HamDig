//
//  HDMainMenuViewController.m
//  HamDig
//
//  Created by Erik Simon on 11/12/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDMainMenuViewController.h"
#import "HDAppDelegate.h"
#import "HDAppDelegateProtocol.h"
#import "HDProvenienceDataViewController.h"
#import "HDPlanDrawingViewController.h"
#import "HDCulturalMaterialsViewController.h"
#import "HDNarrativeViewController.h"
#import "HDLevelFormObject.h"
#import "HDSaveFormViewController.h"

/* This form is for the main menu. Right now only functionality is we create a new dictionary every time we click the "New Form" button.
    Things to add?
    -Edit forms button action
        -right now opening edit forms gets first entry in array and displays title
    -Upload button action
    -Pull Data button action
    -??
 
 ES
*/

@interface HDMainMenuViewController ()

@end

@implementation HDMainMenuViewController

- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
- (IBAction)createForm:(id)sender {
    // initialize dictionary            -ES
    
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    theLevelFormObject.theNewLevelForm = [[NSMutableDictionary alloc] init];
    NSLog(@"create a level form");
    NSLog(@"NewLevelForm Dictionary Initialized");
    

    // anything else we want to do here?
    
}

- (IBAction)exportData:(id)sender {

    
    
    
    
    
    // Still working on this... SR
    
    
    
    
    NSLog(@"Exporting data...");
    
    
    
    //create outputString
    
    
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *outputString = [[appDelegate.allForms objectAtIndex:0] objectForKey:@"formTitle"];
    
    NSLog(@"Output String: %@", outputString);
    
    
    // Creating file...
    
    NSLog(@"Creating file...");
    
    
    
    NSFileManager *filemgr;
    NSArray *filelist;
    int count;
    int i;
    
    filemgr =[NSFileManager defaultManager];
    filelist = [filemgr contentsOfDirectoryAtPath:@"/" error:NULL];
    count = [filelist count];
    
    for (i = 0; i < count; i++)
        NSLog(@"%@", filelist[i]);
    
    
    
    
 //   NSURL *URL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
     
 
//    NSURL *path = [URL URLByAppendingPathComponent:@"output.txt"];
    
  //  NSLog(@"File Name: %@", path);
    
    /*
    NSString *string = ...;
     
    NSError *error;
     
    BOOL ok = [string writeToURL:URL atomically:YES encoding:NSUnicodeStringEncoding error:&error];
     
    if (!ok) {
     
     // an error occurred
     
     NSLog(@"Error writing file at %@\n%@", path, [error localizedFailureReason]);
     
     // implementation continues ...
     
     
     */
     
    


}

/*
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
*/



















@end
