//
//  EHViewController.m
//  Prep For Pirate Assignment
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
    
    NSString *firstString = @"First String";
    NSString *secondString = @"Second String";
    
    NSMutableArray *myMutableArray = [[NSMutableArray alloc] init];
    [myMutableArray addObject:firstString];
    [myMutableArray addObject:secondString];
    
    NSArray *myArray = [[NSArray alloc] initWithObjects:firstString, myMutableArray, secondString, nil];

    NSLog(@"%@", myArray);
    
    self.currentPoint = CGPointMake(3, 4);
    
    int x = 10;
    int y = 20;
    if (x == 10)
    {
        NSLog(@"x equals 10");
        if (y == 20)
        {
            NSLog(@"Both are true.");
        }
    }
    
    [self.myButton setTitle:@"Button Pressed" forState:UIControlStateNormal];
    self.myButton.hidden = true;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"You triggered the alert." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertView show];
    
    self.awesomeClass = [[EHAwesomeClass alloc] init];
    
    NSString *testString = @"has a value";
    
    if (testString != nil)
    {
        NSLog(@"The test string has a value.");
    }
    //NSLog(@"%f %f", self.currentPoint.x, self.currentPoint.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
