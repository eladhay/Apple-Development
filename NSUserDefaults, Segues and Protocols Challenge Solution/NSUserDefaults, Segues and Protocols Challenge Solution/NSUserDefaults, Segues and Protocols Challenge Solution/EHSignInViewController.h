//
//  EHSignInViewController.h
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Elad Hayun on 7/25/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHCreateAccountViewController.h"
#import "EHViewController.h"


@interface EHSignInViewController : UIViewController <EHCreateAccountViewControllerDelegate, UITextFieldDelegate, EHViewControllerDelegate>

// Class Properties
@property (strong, nonatomic) NSMutableArray *userLoginsArray;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

// Delegate Properties Implementation
@property (strong, nonatomic) EHUserLogin *loggedInUser;

// IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;


// Class Methods
//

// IBActions
- (IBAction)loginButtonPressed:(UIButton *)sender;
- (IBAction)createAccountButtonPressed:(UIBarButtonItem *)sender;

@end
