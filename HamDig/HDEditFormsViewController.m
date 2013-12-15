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
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property NSMutableArray *editButtons;
@property NSMutableArray *formTitles;
@property NSMutableArray *deleteButtons;

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
        [self.scrollView addSubview:clickToEdit];
        
        [self.editButtons addObject:clickToEdit];
        
        
        // ... along with the title of each form
        UILabel *formDisplay = [[UILabel alloc] initWithFrame:CGRectMake(200, 100 + (i * 100), 500, 50)];
        formDisplay.text = currentTitle;
        [self.scrollView addSubview:formDisplay];

        [self.formTitles addObject:formDisplay];
        
        UIButton * deleteForm = [[UIButton alloc] initWithFrame:CGRectMake(600, 100 + (i * 100), 100, 50)];
        // background color
        deleteForm.backgroundColor = [UIColor purpleColor];
        // title
        [deleteForm setTitle:@"Delete ME!" forState:UIControlStateNormal];
        // reference to button is index + 1     (because 0 defaults to the viewController so we have to start at 1)   -ES
        // this means the index of the button is one more than it's corresponding index for the form/dictionary
        deleteForm.tag = i+1;
        // add button action to each button
        [deleteForm addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:deleteForm];

        [self.deleteButtons addObject:deleteForm];
        
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // set up scroll view to see all forms
    CGFloat contentHeight = numForms*100 + 100;
    CGSize scrollContent = CGSizeMake(self.scrollView.contentSize.width, contentHeight);
    [self.scrollView setContentSize:scrollContent];

}

-(void)editButtonClick:(UIButton*)sender
{
    
    // example action that turns each button green
    [(UIButton *)[self.scrollView viewWithTag:sender.tag] setBackgroundColor:[UIColor greenColor]];
    
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

-(void)deleteButtonClick:(UIButton*)sender
{
    //[(UIButton *)[self.scrollView viewWithTag:sender.tag] setBackgroundColor:[UIColor cyanColor]];
    
    // to get the global flag currentlyEditing and set it to true
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.currentlyEditing = ;
    
    // save the index of the dict
    appDelegate.currentDictIndex = sender.tag - 1;
    int i = appDelegate.currentDictIndex;
    
    NSLog(@"dict index: %d", i);
    
    //NSMutableArray * formsToDelete = [NSMutableArray array];
    //NSMutableDictionary * formToDelete = [NSMutableDictionary dictionary];
    //[formsToDelete addObject:formsToDelete];
    
    int arraySize = appDelegate.allForms.count;
    
    if (arraySize != 0) {
        [appDelegate.allForms removeObjectAtIndex:i];
        [sender removeFromSuperview];
        
        [[self.formTitles objectAtIndex:i] removeFromSuperview];
        [[self.editButtons objectAtIndex:i] removeFromSuperview];
        [[self.deleteButtons objectAtIndex:i] removeFromSuperview];
        
        [self.formTitles removeObjectAtIndex:i];
        [self.editButtons removeObjectAtIndex:i];
        [self.deleteButtons removeObjectAtIndex:i];
    }
    else{
        NSLog(@"everything has been deleted");
    }
    NSLog(@"size of allforms is now: %d", appDelegate.allForms.count);
    
//    for (int k = 0; k<arraySize; k++) {
  //      [[self.formTitles objectAtIndex:k] removeFromSuperview];
    //    [[self.editButtons objectAtIndex:k] removeFromSuperview];
      //  [[self.deleteButtons objectAtIndex:k] removeFromSuperview];
    //}
    
//    int x = -1;
  //  for (int j = 0; j<arraySize; j++) {
    //    for (int k = 0; k<3; k++) {
            
      //  }
    //}
    
  
    
    //[self viewDidLoad];
    
    // save a deep copy of the dictionary to use when user clicks menu      -ES
    //NSMutableDictionary * cp = [appDelegate.allForms objectAtIndex:i];
    //appDelegate.dictCopy = [NSMutableDictionary dictionaryWithDictionary:cp];
    
    
    // performs the same segue as the "New Form" button on the Main Menu
    //      Needed to add an identifier to the segue in storyboard under attributes inspector
    //[self performSegueWithIdentifier:@"newFormSegue" sender:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
