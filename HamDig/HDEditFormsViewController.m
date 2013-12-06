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
#import "HDTabFormViewController.h"

@interface HDEditFormsViewController ()

@end

@implementation HDEditFormsViewController
//@synthesize tester;
//@synthesize testField;


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
        NSLog(@"current title: %@", currentTitle);
        
        // display an edit button ...
        UIButton *clickToEdit = [[UIButton alloc] initWithFrame:CGRectMake(25, 100 + (i * 100), 100, 50)];
        // background color
        clickToEdit.backgroundColor = [UIColor blueColor];
        // title
        [clickToEdit setTitle:@"click to edit" forState:UIControlStateNormal];
        // reference to button is index + 1     (because 0 defaults to the viewController so we have to start at 1)   -ES
        // this means the index of the button is one more than it's corresponding index for the form/dictionary
        clickToEdit.tag = i+1;
        // add button action to each button
        [clickToEdit addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:clickToEdit];
        
        
        // ... along with the title of each form
        UILabel *formDisplay = [[UILabel alloc] initWithFrame:CGRectMake(200, 100 + (i * 100), 500, 50)];
        formDisplay.text = currentTitle;
        [self.view addSubview:formDisplay];
        
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)editButtonClick:(UIButton*)sender
{
    
    // example action that turns each button green
    [(UIButton *)[self.view viewWithTag:sender.tag] setBackgroundColor:[UIColor greenColor]];
    
    // to get the global flag currentlyEditing and set it to true
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.currentlyEditing = TRUE;
    
    // save the index of the dict
    appDelegate.currentDictIndex = sender.tag - 1;
    int i = appDelegate.currentDictIndex;

    // save a deep copy of the dictionary to use when user clicks menu      -ES
    NSMutableDictionary * cp = [appDelegate.allForms objectAtIndex:i];
    appDelegate.dictCopy = [NSMutableDictionary dictionaryWithDictionary:cp];
    
    
    // performs the same segue as the "New Form" button on the Main Menu
    //      Needed to add an identifier to the segue in storyboard under attributes inspector
    [self performSegueWithIdentifier:@"newFormSegue" sender:self];

//    [self presentViewController:myController animated:YES completion:Nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
