//
//  EHTaskDetailsViewController.h
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHTaskObject.h"
#import "EHTaskEditViewController.h"

// Save Task Object and Cancel callback protocol.
@protocol EHTaskDetailsViewControllerDelegate <NSObject>

@required

- (void)saveTaskObject;
- (void)didCancel;

@end

@interface EHTaskDetailsViewController : UIViewController <EHEditTaskObjectViewControllerDelegate>

// Class Properties
@property (weak, nonatomic) id <EHTaskDetailsViewControllerDelegate> delegate;
@property (strong, nonatomic) EHTaskObject *taskObject;

// IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDueDateDatePicker;
@property (strong, nonatomic) IBOutlet UISwitch *taskCompleteSwitch;

// Class Methods

// IBActions


@end
