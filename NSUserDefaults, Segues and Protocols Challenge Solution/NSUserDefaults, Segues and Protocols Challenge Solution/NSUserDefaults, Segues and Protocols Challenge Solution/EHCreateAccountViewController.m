//
//  EHCreateAccountViewController.m
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Elad Hayun on 7/25/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHCreateAccountViewController.h"

@interface EHCreateAccountViewController ()

@end

@implementation EHCreateAccountViewController

#pragma mark - View Controller

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
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Buttons

- (IBAction)createAccountButtonPressed:(UIButton *)sender
{
    if ([self.usernameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""] || [self.confirmPasswordTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MESSAGE_ACCOUNT_CREATION_ERROR message:MESSAGE_REQUIRED_FIELDS delegate:nil cancelButtonTitle:BUTTON_TEXT_TRY_AGAIN otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MESSAGE_ACCOUNT_CREATION_ERROR message:MESSAGE_PASSWORDS_MISMATCH delegate:nil cancelButtonTitle:BUTTON_TEXT_TRY_AGAIN otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
        
    EHUserLogin *newUserLogin = [self returnNewUserLogin];
    [self.delegate didCreateAccount:newUserLogin];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}

#pragma mark - Helper Methods

- (EHUserLogin *)returnNewUserLogin
{
    EHUserLogin *addedUserLogin = [EHUserLogin new];
    addedUserLogin.username = self.usernameTextField.text;
    addedUserLogin.password = self.passwordTextField.text;
    
    return addedUserLogin;
}

#pragma mark - UITextField Delegate Implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self createAccountButtonPressed:self.createAccountButton];
    return true;
}

@end
