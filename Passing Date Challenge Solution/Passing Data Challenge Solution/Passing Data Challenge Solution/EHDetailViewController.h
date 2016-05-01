//
//  EHDetailViewController.h
//  Passing Data Challenge Solution
//
//  Created by Elad Hayun on 7/22/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EHUpdateDetailViewControllerDelegate <NSObject>

@required

- (void)didUpdateText:(NSString *)text;

@end

@interface EHDetailViewController : UIViewController <UITextFieldDelegate>

// IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UITextField *updateTextField;

// Class Properties
@property (strong, nonatomic) NSString *textProxy;

// Delegate Properties
@property (weak, nonatomic) id <EHUpdateDetailViewControllerDelegate> delegate;

// IBActions
- (IBAction)updateButtonPressed:(UIButton *)sender;

// Class Methods

@end
