//
//  EHViewController.m
//  Age of Laika
//
//  Created by Elad Hayun on 7/18/14.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)convertToHumanAge:(UIButton *)sender
{
    int humanYears = [self.dogYearsTextField.text intValue];
    int dogYears = humanYears * 7;
    self.humanYearsLabel.text = [NSString stringWithFormat:@"Your dog's age in human years is: %i", dogYears];
}

- (IBAction)convertToRealDogYearsButtonPressed:(UIButton *)sender
{
    int humanYears = [self.dogYearsTextField.text intValue];
    int dogYears;
    
    if (humanYears > 2) {
        dogYears = (10.5 * 2) + ((humanYears - 2) * 4);
    }
    else {
        dogYears = 10.5 * humanYears;
    }
    
    self.realYearsLabel.text = [NSString stringWithFormat:@"Your dog's age in human years is: %i", dogYears];
}

@end
