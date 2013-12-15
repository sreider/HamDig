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
}

@property (nonatomic, readwrite) NSMutableDictionary* theNewLevelForm;

@end
