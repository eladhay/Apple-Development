//
//  EHViewController.h
//  Age of Laika
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *dogYearsTextField;

@property (strong, nonatomic) IBOutlet UILabel *humanYearsLabel;

@property (strong, nonatomic) IBOutlet UILabel *realYearsLabel;

- (IBAction)convertToHumanAge:(UIButton *)sender;

- (IBAction)convertToRealDogYearsButtonPressed:(UIButton *)sender;

@end
