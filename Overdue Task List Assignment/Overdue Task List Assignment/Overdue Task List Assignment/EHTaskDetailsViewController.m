//
//  EHTaskDetailsViewController.m
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHTaskDetailsViewController.h"

@interface EHTaskDetailsViewController ()

@end

@implementation EHTaskDetailsViewController

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
    
    [self refreshTaskObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EHEditTaskObjectViewController Delegate

// The cancel button was clicked on the EHEditTaskObjectViewController
- (void)didCancel
{
    // Dismiss the view without doing anything.
    [self.navigationController popViewControllerAnimated:true];
    
    //Let our delegate know the cancel button was pressed.
    [self.delegate didCancel];
}

// The add button was clicked on the EHEditTaskObjectViewController
- (void)saveTaskObject
{
    // Refresh the task object view.
    [self refreshTaskObject];
    
    // Dismiss the view.
    [self.navigationController popViewControllerAnimated:true];
    
    // Call our delegate and update the task.
    [self.delegate saveTaskObject];
}

#pragma mark - Helper Methods

// Reflect the information from the task object property in the UI elements.
- (void)refreshTaskObject
{
    self.taskTitleTextField.text = self.taskObject.taskTitle;
    self.taskDescriptionTextView.text = self.taskObject.taskDescription;
    [self.taskDueDateDatePicker setDate:self.taskObject.taskDueDate animated:true];
    self.taskCompleteSwitch.on = self.taskObject.taskCompleted;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIBarButtonItem class]])
    {
        if ([segue.destinationViewController isKindOfClass:[EHTaskEditViewController class]]) {
            EHTaskEditViewController *editTaskObjectViewController = segue.destinationViewController;
            editTaskObjectViewController.taskObject = self.taskObject;
            editTaskObjectViewController.delegate = self;
        }
    }
}

@end
