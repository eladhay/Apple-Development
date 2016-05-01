//
//  EHViewController.m
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Elad Hayun on 7/24/14.
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
    self.usernameLabel.text = self.delegate.loggedInUser.username;
    self.passwordLabel.text = self.delegate.loggedInUser.password;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoffButtonPressed:(UIButton *)sender
{
    self.delegate.loggedInUser = nil;
    [self.delegate didLogOff];
}

@end
