//
//  EHViewController.h
//  Passing Data Challenge Solution
//
//  Created by Elad Hayun on 7/22/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHDetailViewController.h"

@interface EHViewController : UIViewController <EHUpdateDetailViewControllerDelegate, UITextFieldDelegate>

- (IBAction)buttonNewPagePressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *buttonNewPage;

// Class Properties
@property (strong, nonatomic) IBOutlet UITextField *textField;

@end
