//
//  HDEditFormsViewController.m
//  HamDig
//
//  Created by Erik Simon on 11/5/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDEditFormsViewController.h"
#import "HDLevelFormObject.h"
#import "HDAppDelegateProtocol.h"
#import "HDAppDelegate.h"

@interface HDEditFormsViewController ()

@end

@implementation HDEditFormsViewController
@synthesize tester;
@synthesize testField;

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
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    //HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    

    // make sure there is something in the array            -ES
    int numForms = [appDelegate.allForms count];

    // loops through array and gets info from each dict         -ES
    for (int i = 0; i<numForms;i++){
        // get dictionary at index i
        NSMutableDictionary *currentDict = [appDelegate.allForms objectAtIndex:i];
        // save the form's title
        NSString *currentTitle = [currentDict objectForKey:@"formTitle"];
        // display title
        NSLog(currentTitle);

        // still working on displaying each form title          -ES
        
        //UITextField *formDisplay = [[UITextField alloc] initWithFrame:CGRectMake(10, i * 30, 100, 100)];
        //formDisplay.text = currentTitle;
        
        tester = [[appDelegate.allForms objectAtIndex:0] objectForKey:@"formTitle"];
        testField.text = tester;
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
