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
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    tester = [theLevelFormObject.theNewLevelForm objectForKey:@"stratum"];
    //tester = theLevelFormObject.stratum;
    testField.text = tester;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
