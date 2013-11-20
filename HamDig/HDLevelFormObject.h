//
//  HDLevelFormObject.h
//  HamDig
//
//  Created by Leah Wolf on 10/29/13.
//  Copyright (c) 2013 Hamilton College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDLFObject.h"

@interface HDLevelFormObject : HDLFObject
{
    NSMutableDictionary *theNewLevelForm;
    
    
    //Provenience Data
    NSString* stratum;
    NSString* stratumLevel;
    NSString* date;
    NSString* level;
    NSString* totalLevels;
    NSString* areaDescription;
    NSString* unitEasting;
    NSString* unitNorthing;
    NSString* unitSizeX;
    NSString* unitSizeY;
    NSString* verticalDatumID;
    NSString* datumStringElevation;
    NSString* excavationInterval;
    NSString* screenSize;
    NSMutableArray *excavators; 
    
    //Plan Drawing
    
    
    //Cultural Materials
    NSMutableArray *artifacts;
    NSMutableArray *samples;
    NSMutableArray *features;
    
    
    //Narrative
    NSString* excavationDescription;
    NSString* sedimentDescription;
    NSString* otherNarrative;
    
    
    
    
    
    
}


@property (nonatomic, readwrite) NSMutableDictionary* theNewLevelForm;

@property (nonatomic, copy) NSString* stratum;
@property (nonatomic, copy) NSString* stratumLevel;
@property (nonatomic, copy) NSString* date;
@property (nonatomic, copy) NSString* level;
@property (nonatomic, copy) NSString* totalLevels;
@property (nonatomic, copy) NSString* areaDescription;
@property (nonatomic, copy) NSString* unitEasting;
@property (nonatomic, copy) NSString* unitNorthing;
@property (nonatomic, copy) NSString* unitSizeX;
@property (nonatomic, copy) NSString* unitSizeY;
@property (nonatomic, copy) NSString* verticalDatumID;
@property (nonatomic, copy) NSString* datumStringElevation;
@property (nonatomic, copy) NSString* excavationInterval;
@property (nonatomic, copy) NSString* screenSize;
@property (nonatomic, readwrite) NSMutableArray* excavators;
@property (nonatomic, readwrite) NSMutableArray *artifacts;
@property (nonatomic, readwrite) NSMutableArray *samples;
@property (nonatomic, readwrite) NSMutableArray *features;


@property (nonatomic, copy) NSString* excavationDescription;
@property (nonatomic, copy) NSString* sedimentDescription;
@property (nonatomic, copy) NSString* otherNarrative;


-(void)save;

@end
