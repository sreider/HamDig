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
   /* HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    // turn the global currentlyEditing flag off because we have now either saved or returned to the main menu
    appDelegate.currentlyEditing = FALSE;
    [super viewDidLoad]; */
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
    
    //Initializes the mutable arrays in a new dictionary
    //Might be needed, but could possibly delete this -LW
    [theLevelFormObject.theNewLevelForm setObject:[[NSMutableArray alloc] init] forKey:@"artifacts"];
    [theLevelFormObject.theNewLevelForm setObject:[[NSMutableArray alloc] init] forKey:@"features"];
    [theLevelFormObject.theNewLevelForm setObject:[[NSMutableArray alloc] init] forKey:@"samples"];
    [theLevelFormObject.theNewLevelForm setObject:[[NSMutableArray alloc] init] forKey:@"excavators"];
 

    // anything else we want to do here?
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    // turn the global currentlyEditing flag off because we have now either saved or returned to the main menu
    appDelegate.currentlyEditing = FALSE;
    [super viewDidLoad];
}

- (IBAction)exportData:(id)sender {

    // Still working on this... SR
    
    
    NSLog(@"Exporting data...");
    
    
    
    //create outputString
    
    
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    
    NSString * digName = [[appDelegate.allForms objectAtIndex:0] objectForKey:@"formTitle"];
    NSString * northing = [[appDelegate.allForms objectAtIndex:0] objectForKey:@"unitNorthing"];
    NSString * easting = [[appDelegate.allForms objectAtIndex:0] objectForKey:@"unitEasting"];
    NSString * stratum = [[appDelegate.allForms objectAtIndex:0] objectForKey:@"stratum"];
    NSString * level = [[appDelegate.allForms objectAtIndex:0] objectForKey:@"stratumLevel"];
    
    
    NSString *outputString = [NSString stringWithFormat:@"Name=%@;Northing=%@;Easting=%@;UnitSizeW=.98;UnitSizeH=.99;Stratum=%@;Level=%@;Excavators=[Test];VerticalDatumID=A;DatumStringElevation=1.0;ExcavationInterval=1", digName, northing, easting, stratum, level ];
    
    
    
   
    
    NSLog(@"Output String: %@", outputString);
    
    
    // Creating file...
    
    NSLog(@"Creating file...");
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"Documents Directory: %@", documentsDirectory);
    
    
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"HamDigOutput.txt"];
    
    
    BOOL ok = [outputString writeToFile:appFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!ok) {
        
        // an error occurred
        
        NSLog(@"Error writing file at %@\n%@", appFile, [error localizedFailureReason]);
    
    }
    else {
        NSLog(@"Successfully wrote file!");
    }

}



@end
