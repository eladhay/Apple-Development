//
//  EHViewController.h
//  Prereq for Overdue Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)buttonPressed:(UIButton *)sender;

@end
