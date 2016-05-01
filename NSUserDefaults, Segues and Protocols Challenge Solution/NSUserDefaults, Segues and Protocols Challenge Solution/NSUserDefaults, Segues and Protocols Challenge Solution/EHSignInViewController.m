//
//  EHSignInViewController.m
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Elad Hayun on 7/25/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHSignInViewController.h"

@interface EHSignInViewController ()

@end

@implementation EHSignInViewController

#pragma mark - Lazy Instantiation of Properties

- (NSMutableArray *)userLoginsArray
{
    if (!_userLoginsArray)
    {
        _userLoginsArray = [NSMutableArray new];
    }
    
    return _userLoginsArray;
}

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
    
    self.loggedInUser = nil;
    
    [self resetView];
    [self loadUserLogins];
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
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
    if ([segue.destinationViewController isKindOfClass:[EHCreateAccountViewController class]])
    {
        EHCreateAccountViewController *createAccountViewController = segue.destinationViewController;
        createAccountViewController.delegate = self;
    }    
    else if ([segue.destinationViewController isKindOfClass:[EHViewController class]])
    {
        EHViewController *loggedInViewController = segue.destinationViewController;
        loggedInViewController.delegate = self;
    }
}

#pragma mark - Buttons

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    if ([self.usernameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MESSAGE_ACCOUNT_LOGIN_ERROR message:MESSAGE_REQUIRED_FIELDS delegate:nil cancelButtonTitle:BUTTON_TEXT_TRY_AGAIN otherButtonTitles:nil, nil];
        [alertView show];
        
        self.loggedInUser = nil;
        return;
    }
    
    for (EHUserLogin *retreivedUserLogin in self.userLoginsArray)
    {
        if ([retreivedUserLogin.username isEqualToString:self.usernameTextField.text])
        {
            if (![retreivedUserLogin.password isEqualToString:self.passwordTextField.text])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MESSAGE_ACCOUNT_LOGIN_ERROR message:MESSAGE_WRONG_USERNAME_PASSWORD delegate:nil cancelButtonTitle:BUTTON_TEXT_TRY_AGAIN otherButtonTitles:nil, nil];
                [alertView show];
                self.loggedInUser = nil;
                return;
            }
            else
            {
                self.loggedInUser = retreivedUserLogin;
                [self performSegueWithIdentifier:@"toViewController" sender:sender];
                return;
            }
            
            return;
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:MESSAGE_ACCOUNT_LOGIN_ERROR message:MESSAGE_WRONG_USERNAME_PASSWORD delegate:nil cancelButtonTitle:BUTTON_TEXT_TRY_AGAIN otherButtonTitles:nil, nil];
    [alertView show];
    self.loggedInUser = nil;
}

- (IBAction)createAccountButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toCreateAccountViewController" sender:sender];
}

#pragma mark - EHCreateAccountViewController Delegate Implementation

- (void) didCancel
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) didCreateAccount:(EHUserLogin *)newUserLogin
{
    // Add the newUserLogin object to the userLoginsArray array.
    [self.userLoginsArray addObject:newUserLogin];
    
    // Try reading the saved user logins from NSUserDefaults
    NSMutableArray *userLoginsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:USER_LOGINS] mutableCopy];
    
    // If NSUserDefaults had no user logins objects saved, make sure to initialize the array as new.
    if (!userLoginsAsPropertyLists) userLoginsAsPropertyLists = [NSMutableArray new];
    
    // Add the user login object to the new property list array after converting it to a property list.
    [userLoginsAsPropertyLists addObject:[EHUserLogin userLoginObjectAsPropertyList:newUserLogin]];
    
    // Save everything to NSUserDefaults and synchronize to persistent storage.
    [[NSUserDefaults standardUserDefaults] setObject:userLoginsAsPropertyLists forKey:USER_LOGINS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:true completion:nil];
    [self loadUserLogins];
}

#pragma mark - EHViewController Delegate Implementation

- (void) didLogOff
{
    [self resetView];
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UITextField Delegate Implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self loginButtonPressed: self.loginButton];
    return true;
}

#pragma mark - Helper Methods

- (void)resetView
{
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
}

- (void)loadUserLogins
{
    NSArray *myUserLoginsArray = [[NSUserDefaults standardUserDefaults] arrayForKey:USER_LOGINS];
    for (NSDictionary *dictionary in myUserLoginsArray)
    {
        EHUserLogin *userLoginObject = [EHUserLogin userLoginObjectForDictionary:dictionary];
        NSLog(@"%@", userLoginObject.username);
        [self.userLoginsArray addObject:userLoginObject];
    }
}

@end
