//
//  EHDetailViewController.m
//  Passing Data Challenge Solution
//
//  Created by Elad Hayun on 7/22/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHDetailViewController.h"

@interface EHDetailViewController ()

@end

@implementation EHDetailViewController

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
    
    self.detailLabel.text = self.textProxy;
    self.updateTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)updateButtonPressed:(UIButton *)sender
{
    self.detailLabel.text = self.updateTextField.text;
    [self.delegate didUpdateText:self.updateTextField.text];
}

// Delegate Implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.detailLabel.text = self.updateTextField.text;
    [self.delegate didUpdateText:self.updateTextField.text];
    [self.updateTextField resignFirstResponder];
    return true;
}

@end
