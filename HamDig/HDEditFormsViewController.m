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
#include "HDPopovers.h"

@interface HDEditFormsViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property NSMutableArray *editButtons;
@property NSMutableArray *formTitles;
@property NSMutableArray *deleteButtons;
@property NSMutableArray *boxes;

@property (nonatomic, strong) UIPopoverController *deleteConformation;

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
    
    // initialize the arrays keeping track of graphics for forms
    self.deleteButtons = [[NSMutableArray alloc] init];
    self.formTitles = [[NSMutableArray alloc] init];
    self.editButtons = [[NSMutableArray alloc] init];
    self.boxes = [[NSMutableArray alloc] init];
    
    // loops through array and gets info from each dict         -ES
    for (int i = 0; i<numForms;i++){
        // get dictionary at index i
        NSMutableDictionary *currentDict = [appDelegate.allForms objectAtIndex:i];
        // save the form's title
        NSString *currentTitle = [currentDict objectForKey:@"formTitle"];
        // display title
        NSLog(@"current title: %@", currentTitle);
        
        //Displays a box around each form object
        UIView *box = [[UIView alloc] initWithFrame:CGRectMake(25, 35 + (i *100), 700, 75)];
        box.backgroundColor = [UIColor brownColor];
        [self.scrollView addSubview:box];
        [self.boxes addObject:box];
        box.tag = i+1;
        
        // display an edit button ...
        UIButton *clickToEdit = [[UIButton alloc] initWithFrame:CGRectMake(25, 35 + (i * 100), 100, 75)];

        // title
        [clickToEdit setTitle:@"Edit Form" forState:UIControlStateNormal];
        // reference to button is index + 1     (because 0 defaults to the viewController so we have to start at 1)   -ES
        // this means the index of the button is one more than it's corresponding index for the form/dictionary
        clickToEdit.tag = i+1;
        // add button action to each button
        [clickToEdit addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:clickToEdit];
        
        [self.editButtons addObject:clickToEdit];
        
        
        // ... along with the title of each form
        UILabel *formDisplay = [[UILabel alloc] initWithFrame:CGRectMake(200, 50 + (i * 100), 500, 50)];
        formDisplay.text = currentTitle;
        [self.scrollView addSubview:formDisplay];

        [self.formTitles addObject:formDisplay];
        
        UIButton * deleteForm = [[UIButton alloc] initWithFrame:CGRectMake(600, 35 + (i * 100), 100, 75)];
        // background color
       // deleteForm.backgroundColor = [UIColor brownColor] ;
        // title
        [deleteForm setTitle:@"Delete Form" forState:UIControlStateNormal];
        // reference to button is index + 1     (because 0 defaults to the viewController so we have to start at 1)   -ES
        // this means the index of the button is one more than it's corresponding index for the form/dictionary
        deleteForm.tag = i+1;
        // add button action to each button
        
        
        /// CALL POPOVER - COMMENTED OUT BECAUSE BROKENNN
//        [deleteForm addTarget:self action:@selector(showPopover:) forControlEvents:UIControlEventTouchUpInside];
        
        [deleteForm addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:deleteForm];

        [self.deleteButtons addObject:deleteForm];
        
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    HDPopovers *confirm = [self.storyboard instantiateViewControllerWithIdentifier:@"deleteConfirm"];
    self.deleteConformation = [[UIPopoverController alloc] initWithContentViewController:confirm];
    self.deleteConformation.delegate = self;
    
    // set up scroll view to see all forms
    CGFloat contentHeight = numForms*100 + 100;
    CGSize scrollContent = CGSizeMake(self.scrollView.contentSize.width, contentHeight);
    [self.scrollView setContentSize:scrollContent];

}



-(void)editButtonClick:(UIButton*)sender
{
    
    // example action that turns each button green
    //[(UIButton *)[self.scrollView viewWithTag:sender.tag] setBackgroundColor:[UIColor greenColor]];
    
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
    
}

-(void)deleteButtonClick:(UIButton*)sender
{

    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // save the index of the dict
    //This doesn't work if you delete from the middle of the array.... -LW
    appDelegate.currentDictIndex = sender.tag - 1;
    int i = appDelegate.currentDictIndex;
    
    NSLog(@"dict index: %d", i);
    
    
    int arraySize = appDelegate.allForms.count;
    
    if (arraySize > 0) {
        [appDelegate.allForms removeObjectAtIndex:i];
        [sender removeFromSuperview];
        
        [[self.formTitles objectAtIndex:i] removeFromSuperview];
        [[self.editButtons objectAtIndex:i] removeFromSuperview];
        [[self.deleteButtons objectAtIndex:i] removeFromSuperview];
        [[self.boxes objectAtIndex:i] removeFromSuperview];
        
        [self.formTitles removeObjectAtIndex:i];
        [self.editButtons removeObjectAtIndex:i];
        [self.deleteButtons removeObjectAtIndex:i];
        [self.boxes removeObjectAtIndex:i];
    }
    else{
        NSLog(@"everything has been deleted");
    }

    
    // update array size because items have now been removed
    arraySize = appDelegate.allForms.count;
    
    // reset all the tag for edit and delete buttons
    for (int k = 0; k<arraySize; k++) {
        // tags are always 1 more than the index
        [[self.editButtons objectAtIndex:k] setTag:k+1];
        [[self.deleteButtons objectAtIndex:k] setTag:k+1];
        
        UILabel *currentTitle = [self.formTitles objectAtIndex:k];
        //[currentTitle setTextColor: [UIColor redColor]];
        NSLog(@"%@", [currentTitle text]);
    }
    
    for (int j = i; j<arraySize; j++) {
        // move the form title up
        UILabel *currentTitle = [self.formTitles objectAtIndex:j];
        //[currentTitle setTextColor: [UIColor redColor]];
        //NSLog(@"%@", [currentTitle text]);
        CGRect textFieldFrame = currentTitle.frame;
        textFieldFrame.origin.y -= 100;
        currentTitle.frame = textFieldFrame;
        
        // move edit buttons up
        UIButton *currentEditButton = [self.editButtons objectAtIndex:j];
        CGRect editButtonFrame = currentEditButton.frame;
        editButtonFrame.origin.y -= 100;
        currentEditButton.frame = editButtonFrame;
        
        // move delete buttons up
        UIButton *currentDeleteButton = [self.deleteButtons objectAtIndex:j];
        CGRect deleteButtonFrame = currentDeleteButton.frame;
        deleteButtonFrame.origin.y -= 100;
        currentDeleteButton.frame = deleteButtonFrame;
    }

    
    
}


///// Popover window for confirming delete -JB /////
- (void)showPopover:(UIButton*)sender {
    UIButton *tappedButton = (UIButton *) sender;
    [self.deleteConformation presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
