//
//  EHAddTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHAddTaskViewController.h"

@interface EHAddTaskViewController ()

@end

@implementation EHAddTaskViewController

#pragma mark - View Controller Methods

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set the required UI elements' delgate property.
    self.taskDescriptionTextView.delegate = self;
    self.taskTitleTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextView Delegate

// The delegate method to handle the Return/Enter key being pressed in the UITextView control.
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.taskDescriptionTextView resignFirstResponder];
        return false;
    }
    else
    {
        return true;
    }
}

#pragma mark - UITextField Delegate

// The delegate method to handle the Return/Enter key being pressed in the UITextField control.
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTitleTextField resignFirstResponder];
    return true;
}

#pragma mark - UI Buttons

// The save button was pressed.
- (IBAction)buttonSavePressed:(UIBarButtonItem *)sender
{
    // Make sure the new task has, atleast, a title and description.
    if ([self.taskTitleTextField.text isEqualToString:@""] || [self.taskDescriptionTextView.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MESSAGE_TASK_CREATION_ERROR message:MESSAGE_TASK_REQUIRED_FIELDS delegate:nil cancelButtonTitle:BUTTON_TEXT_TRY_AGAIN otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    // Create a new task object.
    EHTaskObject *newTaskObject = [self returnNewTaskObject];
    
    // Pass the new task object to the delegate.
    [self.delegate addTaskObject:newTaskObject];
}

// The cancel button was pressed.
- (IBAction)buttonCancelPressed:(UIBarButtonItem *)sender
{
    // Let our delegate know that cancel was pressed.
    [self.delegate didCancel];
}

#pragma mark - Helper Methods

// Create and return a new task object.
- (EHTaskObject *)returnNewTaskObject
{
    EHTaskObject *addedTaskObject = [EHTaskObject new];
    addedTaskObject.taskTitle = self.taskTitleTextField.text;
    addedTaskObject.taskDescription = self.taskDescriptionTextView.text;
    addedTaskObject.taskDueDate = self.taskDueDateDatePicker.date;
    addedTaskObject.taskCompleted = false;
    
    return addedTaskObject;
}

#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
