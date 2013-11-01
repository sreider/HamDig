//
//  HDLevelFormObject.m
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import "HDLevelFormObject.h"
#import "HDAppDelegate.h"

@implementation HDLevelFormObject

@synthesize stratum;
@synthesize stratumLevel;
@synthesize date;
@synthesize level;
@synthesize totalLevels;
@synthesize areaDescription;
@synthesize unitEasting;
@synthesize unitNorthing;
@synthesize unitSizeX;
@synthesize unitSizeY;
@synthesize verticalDatumID;
@synthesize datumStringElevation;
@synthesize excavationInterval;
@synthesize screenSize;
@synthesize excavators;

@synthesize excavationDescription;
@synthesize sedimentDescription;
@synthesize otherNarrative;


@synthesize theNewLevelForm;

- (void)save
{
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate] ;
    
    
    [appDelegate.allForms addObject:(theNewLevelForm)];
    
	NSLog(@"the code runs through here!");
	
}



@end
