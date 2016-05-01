//
//  EHViewController.h
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Elad Hayun on 7/24/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHUserLogin.h"

@protocol EHViewControllerDelegate <NSObject>

@required

- (void)didLogOff;

@property (strong, nonatomic) EHUserLogin* loggedInUser;

@end

@interface EHViewController : UIViewController

// IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;

// Class Properties
@property (weak, nonatomic) id <EHViewControllerDelegate> delegate;

// IBActions
- (IBAction)logoffButtonPressed:(UIButton *)sender;

// Class Methods

@end
