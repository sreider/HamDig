
    //
//  HDSaveFormViewController.m
//  HamDig
//
//  Created by Sampson Reider on 11/12/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDSaveFormViewController.h"
#import "HDLevelFormObject.h"
#import "HDAppDelegateProtocol.h"
#import "HDAppDelegate.h"


@interface HDSaveFormViewController ()

@end

@implementation HDSaveFormViewController


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
    // if editing, prepopulate the form title
    if (appDelegate.currentlyEditing){
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary * currentDict = [appDelegate.allForms objectAtIndex:i];
        formTitle.text = [currentDict objectForKey:@"formTitle"];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidEndEditing:(UITextField *)textField
//When you finish editing a text field, saves the current values on the page.
{
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
	HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    // same as code for save button to make sure changes affect correct form if editing
    if (!appDelegate.currentlyEditing){
        [theLevelFormObject.theNewLevelForm setObject:formTitle.text forKey:@"formTitle"];
        NSLog(@"Form Title: %@", [theLevelFormObject.theNewLevelForm objectForKey:@"formTitle"]);
    }
    else{
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary * currentDict = [appDelegate.allForms objectAtIndex:i];
        NSLog(@"Form Title: %@", [currentDict objectForKey:@"formTitle"]);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return TRUE;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // WE NEED THIS!!! -SR
}


- (IBAction)save:(UIButton *)sender {
    
    NSLog(@"Save button!");
    
    
    
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    
    
    // add the dictionary to the global array           -ES
    // only if user is not editing
    if (!(appDelegate.currentlyEditing)){
        NSLog(@"Adding form to array because editing flag is off");
            // to make sure the form title is being saved if user does not hit return                -ES
  
        [theLevelFormObject.theNewLevelForm setObject:formTitle.text forKey:@"formTitle"];
        [appDelegate.allForms addObject:theLevelFormObject.theNewLevelForm];
    }
    else{
        NSLog(@"replacing dict at index because editing flag is on");
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary * currentDict = [appDelegate.allForms objectAtIndex:i];
        [currentDict setObject:formTitle.text forKey:@"formTitle"];

        NSLog(@"turning the editing flag off");
        appDelegate.currentlyEditing = FALSE;
    }
}
@end
