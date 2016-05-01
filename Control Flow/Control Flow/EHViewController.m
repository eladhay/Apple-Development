//
//  EHViewController.m
//  Control Flow
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
    
    int truckSpeed = 45;
    int lamboSpeed = 120;
    int carSpeed = 80;
    int mySpeed = carSpeed;
    
    // < > <= >= != == || &&
    if (mySpeed < 70) {
        NSLog(@"Keep Cruising.");
    }
    else if (mySpeed > 55 && mySpeed < 90)
    {
        NSLog(@"You're cruising down highway 66.");
    }
    else {
        NSLog(@"Slow Down.");
    }
    
    BOOL isTelevisionOn = YES;
    if (isTelevisionOn == YES){
        NSLog(@"We should take a break soon and do some coding.");
    }
    else{
        NSLog(@"Great job! Keep up the hard work.");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
