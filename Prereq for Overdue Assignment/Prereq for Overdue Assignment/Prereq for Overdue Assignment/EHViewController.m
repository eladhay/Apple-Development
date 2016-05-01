//
//  EHViewController.m
//  Prereq for Overdue Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHViewController.h"

@interface EHViewController ()

@end

@implementation EHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", self.textView.text);
    self.textView.delegate = self;
    
    NSMutableArray *myMutableArray = [@[@1, @"hello", @3, @"goodbye"] mutableCopy];
    [myMutableArray insertObject:@"first" atIndex:0];
    NSLog(@"%@", myMutableArray);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.textView resignFirstResponder];
        return false;
    }
    else
    {
        return true;
    }
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    self.dateLabel.text = stringFromDate;
    
    int timerInterval = [date timeIntervalSince1970];
    NSLog(@"%i", timerInterval);
}

@end
