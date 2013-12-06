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
#import "HDAppDelegate.h"


@interface HDNarrativeViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextView *activeField; //is set when a textView becomes first responder

@end

@implementation HDNarrativeViewController

- (HDLevelFormObject*) theLevelFormObject;
{
	id<HDAppDelegateProtocol> theDelegate = (id<HDAppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	HDLevelFormObject* theLevelFormObject;
	theLevelFormObject = (HDLevelFormObject*) theDelegate.theLevelFormObject;
	return theLevelFormObject;
}

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//	HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
//	theLevelFormObject.excavationDescription = excavationDescription.text;
//    theLevelFormObject.sedimentDescription = sedimentDescription.text;
//    theLevelFormObject.otherNarrative = otherNarrative.text;
//}

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    theLevelFormObject.excavationDescription = excavationDescription.text;
    theLevelFormObject.sedimentDescription = sedimentDescription.text;
    theLevelFormObject.otherNarrative = otherNarrative.text;

    if (appDelegate.currentlyEditing){
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary * currentDict = [appDelegate.allForms objectAtIndex:i];
        [currentDict setObject:excavationDescription.text forKey:@"excavationDescription"];
        [currentDict setObject:sedimentDescription.text forKey:@"sedimentDescription"];
        [currentDict setObject:otherNarrative.text forKey:@"otherNarrative"];
    }
    else {
        [theLevelFormObject.theNewLevelForm setObject:excavationDescription.text forKey:@"excavationDescription"];
        [theLevelFormObject.theNewLevelForm setObject:sedimentDescription.text forKey:@"sedimentDescription"];
        [theLevelFormObject.theNewLevelForm setObject:otherNarrative.text forKey:@"otherNarrative"];
    }



}

- (void)viewDidLoad
{
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.currentlyEditing) {
        NSLog(@"Editing flag is on");
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary *currentDict = [appDelegate.allForms objectAtIndex:i];
        excavationDescription.text = [currentDict objectForKey:@"excavationDescription"];
        sedimentDescription.text = [currentDict objectForKey:@"sedimentDescription"];
        otherNarrative.text = [currentDict objectForKey:@"otherNarrative"];
    
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // says what to call when keyboard appears/ disappears
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// based partially on code provided by apple

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.activeField = textView;
}


- (void)textViewDidEndEditing:(UITextView *)textView
// when you finish editing a field, save the current values on the page.
{
    HDAppDelegate *appDelegate = (HDAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.activeField = nil;
    HDLevelFormObject* theLevelFormObject = [self theLevelFormObject];
    
    theLevelFormObject.excavationDescription = excavationDescription.text;
    theLevelFormObject.sedimentDescription = sedimentDescription.text;
    theLevelFormObject.otherNarrative = otherNarrative.text;
    
    // save objects to the dictionary
    if (appDelegate.currentlyEditing){
        int i = appDelegate.currentDictIndex;
        NSMutableDictionary * currentDict = [appDelegate.allForms objectAtIndex:i];
        [currentDict setObject:excavationDescription.text forKey:@"excavationDescription"];
        [currentDict setObject:sedimentDescription.text forKey:@"sedimentDescription"];
        [currentDict setObject:otherNarrative.text forKey:@"otherNarrative"];
    }
    else {
        [theLevelFormObject.theNewLevelForm setObject:excavationDescription.text forKey:@"excavationDescription"];
        [theLevelFormObject.theNewLevelForm setObject:sedimentDescription.text forKey:@"sedimentDescription"];
        [theLevelFormObject.theNewLevelForm setObject:otherNarrative.text forKey:@"otherNarrative"];
    }
    
    //NSLog(@"excavationDescription: %@", [theLevelFormObject.theNewLevelForm objectForKey:@"excavationDescription"]);
    
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);

    self.scrollView.contentSize = self.view.bounds.size;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint origin = self.activeField.frame.origin;
    origin.y -= self.scrollView.contentOffset.y;
    origin.y += self.activeField.frame.size.height;

    if (!CGRectContainsPoint(aRect, origin)) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}


// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillHide:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
