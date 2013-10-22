//
//  HDViewController.m
//  HamDig
//
//  Created by Sampson Reider on 10/20/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDViewController.h"

@interface HDViewController ()

@end

@implementation HDViewController

@synthesize stratum = _stratum;

@synthesize stratumLevel = _stratumLevel;
@synthesize level = _level;
@synthesize totalOfLevels = _totalOfLevels;

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


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == self.stratumTextField) {
        
        [theTextField resignFirstResponder];
        // Closes the keyboard when user hits return
    }
    else if (theTextField == self.stratumLevelTextField) {
        
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.levelTextField) {
        
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.totalOfLevelsTextField) {
        
        [theTextField resignFirstResponder];
    }
    
    return YES;
    
}

@end
