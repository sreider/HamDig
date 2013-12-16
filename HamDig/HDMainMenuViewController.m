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

/* This form is for the main menu.
 
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
    
    [super viewDidLoad];
}

- (IBAction)exportData:(id)sender {
    
    // Still working on this... SR
    
    
    NSLog(@"Exporting data...");
    
    
    
    //create outputString
    
    
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSMutableString *outputString = [NSMutableString string];
    
    for (NSDictionary* form in appDelegate.allForms)
    {
        NSLog(@"form: %@", form);
        
        NSString * digName = [form objectForKey:@"digName"];
        NSString * northing = [form objectForKey:@"unitNorthing"];
        NSString * easting = [form objectForKey:@"unitEasting"];
        NSString * unitSizeW = [form objectForKey:@"unitSizeX"];
        NSString * unitSizeH = [form objectForKey:@"unitSizeY"];
        NSString * stratum = [form objectForKey:@"stratum"];
        NSString * level = [form objectForKey:@"level"];
        NSString * verticalDatumID = [form objectForKey:@"verticalDatumID"];
        NSString * datumStringElevation = [form objectForKey:@"datumStringElevation"];
        NSString * excavationInterval = [form objectForKey:@"excavationInterval"];
        
        
        NSString * areaDescription = [form objectForKey:@"areaDescription"];
        NSString * date = [form objectForKey:@"date"];
        //NSString * formTitle = [form objectForKey:@"formTitle"];
        NSString * screenSize = [form objectForKey:@"screenSize"];
        //    NSString * stratumLevel = [form objectForKey:@"stratumLevel"];
        NSString * totalLevels = [form objectForKey:@"totalLevels"];
        NSString * sedimentDescription = [form objectForKey:@"sedimentDescription"];
        NSString * excavationDescription = [form objectForKey:@"excavationDescription"];
        NSString * otherNarrative = [form objectForKey:@"otherNarrative"];
        
        
        
        
        NSMutableString *artifacts = [NSMutableString string];
        NSMutableString *envSamples = [NSMutableString string];
        NSMutableString *assocFeatures = [NSMutableString string];
        NSMutableString *excavators = [NSMutableString string];
        
        
        
        NSMutableArray * artifactsArray = [form objectForKey:@"artifacts"];
        NSMutableArray * samplesArray = [form objectForKey:@"samples"];
        NSMutableArray * featuresArray = [form objectForKey:@"features"];
        NSMutableArray * excavatorsArray = [form objectForKey:@"excavators"];
        
        [artifacts appendString: @"["];
        for (NSArray * artifactArray in artifactsArray){
            if (artifactArray != artifactsArray[0]){
                [artifacts appendString: @", "];
            }
            
            UITextField * field0 = artifactArray[0];
            NSString * artType = field0.text;
            
            UITextField * field1 = artifactArray[1];
            NSString * artEasting = field1.text;
            
            UITextField * field2 = artifactArray[2];
            NSString * artNorthing = field2.text;
            
            UITextField * field3 = artifactArray[3];
            NSString * artDepth = field3.text;
            
            [artifacts appendString: [NSString stringWithFormat:@"ArtifactType=%@,Northing=%@,Easting=%@,Depth=%@", artType, artNorthing, artEasting, artDepth]];
        }
        [artifacts appendString: @"]"];
        
        
        [envSamples appendString: @"["];
        for (NSArray * sampleArray in samplesArray){
            
            if (sampleArray != samplesArray[0]){
                [envSamples appendString: @", "];
            }
            
            UITextField * field0 = sampleArray[0];
            NSString * samType = field0.text;
            
            UITextField * field1 = sampleArray[1];
            NSString * samEasting = field1.text;
            
            UITextField * field2 = sampleArray[2];
            NSString * samNorthing = field2.text;
            
            UITextField * field3 = sampleArray[3];
            NSString * samDepth = field3.text;
            
            
            [envSamples appendString: [NSString stringWithFormat:@"SampleType=%@,Northing=%@,Easting=%@,Depth=%@", samType, samNorthing, samEasting, samDepth]];
        }
        [envSamples appendString: @"]"];
        
        
        [assocFeatures appendString: @"["];
        for (NSArray * featureArray in featuresArray){
            
            if (featureArray != featuresArray[0]){
                [assocFeatures appendString: @", "];
            }
            
            UITextField * field = featureArray[0];
            [assocFeatures appendString: [NSString stringWithFormat: @"Type=%@", field.text]];
        }
        [assocFeatures appendString: @"]"];
        
        
        [excavators appendString: @"["];
        for (NSArray * excavatorArray in excavatorsArray){
            if (excavatorArray != excavatorsArray[0]){
                [excavators appendString: @", "];
            }
            
            UITextField * field = excavatorArray[0];
            [excavators appendString: field.text];
        }
        [excavators appendString: @"]"];
        
        
        
        
        
        [outputString appendString: [NSString stringWithFormat:@"Name=%@|Northing=%@|Easting=%@|UnitSizeW=%@|UnitSizeH=%@|Stratum=%@|Level=%@|Excavators=%@|VerticalDatumID=%@|DatumStringElevation=%@|ExcavationInterval=%@|AreaDescription=%@|Date=%@|ScreenSize=%@|TotalLevels=%@|Artifact=%@|AssocFeatures=%@|EnvSamples=%@|Sediment=%@|Excavation=%@|Other=%@|~", digName, northing, easting, unitSizeW, unitSizeH, stratum, level, excavators, verticalDatumID, datumStringElevation, excavationInterval, areaDescription, date, screenSize, totalLevels, artifacts, assocFeatures, envSamples, sedimentDescription, excavationDescription, otherNarrative]];
        
        
    }
    
    
    
    
    
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
