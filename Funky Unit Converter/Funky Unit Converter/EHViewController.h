//
//  EHViewController.h
//  Funky Unit Converter
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *numberOfBillsLabel;

@property (strong, nonatomic) IBOutlet UITextField *numberOfBillsTextField;

- (IBAction)convertUnits:(UIButton *)sender;

@end
