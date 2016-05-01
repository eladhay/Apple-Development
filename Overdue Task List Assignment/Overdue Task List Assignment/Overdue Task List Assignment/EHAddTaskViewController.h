//
//  EHAddTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHTaskObject.h"

// Add Task Object and Cancel callback protocol.
@protocol EHAddTaskObjectViewControllerDelegate <NSObject>

@required

- (void)addTaskObject:(EHTaskObject *)taskObject;
- (void)didCancel;

@end

@interface EHAddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

// Class Properties
@property (weak, nonatomic) id <EHAddTaskObjectViewControllerDelegate> delegate;

// IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDueDateDatePicker;

// Class Methods

//IBActions
- (IBAction)buttonCancelPressed:(UIBarButtonItem *)sender;
- (IBAction)buttonSavePressed:(UIBarButtonItem *)sender;

@end
