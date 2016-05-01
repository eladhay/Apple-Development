//
//  EHCreateAccountViewController.h
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Elad Hayun on 7/25/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHUserLogin.h"

@protocol EHCreateAccountViewControllerDelegate <NSObject>

@required

- (void) didCreateAccount:(EHUserLogin *)newUserLogin;
- (void) didCancel;

@end

@interface EHCreateAccountViewController : UIViewController <UITextFieldDelegate>

// Class Properties
@property (weak, nonatomic) id <EHCreateAccountViewControllerDelegate> delegate;

// IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UIButton *createAccountButton;

// Class Methods
//

// IBActions
- (IBAction)createAccountButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
