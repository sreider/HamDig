//
//  HDNarrativeViewController.m
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDNarrativeViewController.h"
#import "HDLevelFormObject.h"
#import "HDAppDelegateProtocol.h"

@implementation HDNarrativeViewController


- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
	theLevelFormObject.excavationDescription = excavationDescription.text;
    theLevelFormObject.sedimentDescription = sedimentDescription.text;
    theLevelFormObject.otherNarrative = otherNarrative.text;
}

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    theLevelFormObject.excavationDescription = excavationDescription.text;
    theLevelFormObject.sedimentDescription = sedimentDescription.text;
    theLevelFormObject.otherNarrative = otherNarrative.text;
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


@end
