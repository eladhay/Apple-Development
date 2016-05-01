//
//  EHTaskEditViewController.h
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHTaskObject.h"

// Save Task Object and Cancel callback protocol.
@protocol EHEditTaskObjectViewControllerDelegate <NSObject>

@required

- (void)saveTaskObject;
- (void)didCancel;

@end

@interface EHTaskEditViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

// Class Properties
@property (weak, nonatomic) id <EHEditTaskObjectViewControllerDelegate> delegate;
@property (strong, nonatomic) EHTaskObject *taskObject;

// IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDueDateDatePicker;
@property (strong, nonatomic) IBOutlet UISwitch *taskCompletedSwitch;

// Class Methods

// IBActions
- (IBAction)buttonSavePressed:(UIBarButtonItem *)sender;
- (IBAction)buttonCancelPressed:(UIBarButtonItem *)sender;

@end
