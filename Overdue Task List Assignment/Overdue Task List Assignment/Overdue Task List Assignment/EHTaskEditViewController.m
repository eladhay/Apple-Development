//
//  EHTaskEditViewController.m
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHTaskEditViewController.h"

@interface EHTaskEditViewController ()

@end

@implementation EHTaskEditViewController

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
    
    // Update the view with the currently selected task object.
    [self refreshTaskObject];
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

#pragma mark - UIButtons

// The save button was clicked on the EHEditTaskObjectViewController
- (IBAction)buttonSavePressed:(UIBarButtonItem *)sender
{
    [self updateTaskObject];
    [self refreshTaskObject];
    [self.delegate saveTaskObject];
}

// The cancel button was clicked on the EHEditTaskObjectViewController
- (IBAction)buttonCancelPressed:(UIBarButtonItem *)sender
{
    [self.delegate didCancel];
}

#pragma mark - Helper Methods

// Reflect the information from the task object property in the UI elements.
- (void)refreshTaskObject
{
    self.taskTitleTextField.text = self.taskObject.taskTitle;
    self.taskDescriptionTextView.text = self.taskObject.taskDescription;
    [self.taskDueDateDatePicker setDate:self.taskObject.taskDueDate animated:true];
    self.taskCompletedSwitch.on = self.taskObject.taskCompleted;
}

// Update the task object property with the information in the UI.
- (void)updateTaskObject
{
    self.taskObject.taskTitle = self.taskTitleTextField.text;
    self.taskObject.taskDescription = self.taskDescriptionTextView.text;
    self.taskObject.taskDueDate = self.taskDueDateDatePicker.date;
    self.taskObject.taskCompleted = self.taskCompletedSwitch.on;
}


#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
