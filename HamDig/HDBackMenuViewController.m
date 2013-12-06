//
//  HDBackMenuViewController.m
//  HamDig
//
//  Created by Erik Simon on 12/4/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDBackMenuViewController.h"
#import "HDAppDelegate.h"
@interface HDBackMenuViewController ()

@end

@implementation HDBackMenuViewController

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
- (IBAction)changeFlag:(id)sender {
    /*
     This means the u
    */

    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentlyEditing){
        appDelegate.currentlyEditing = FALSE;
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary *currentDict = [appDelegate.allForms objectAtIndex:i];
        currentDict = appDelegate.dictCopy;
        [appDelegate.allForms setObject:currentDict atIndexedSubscript:i];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
