//
//  EHViewController.m
//  For Loops
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
    
//    for (int meditationHours = 1; meditationHours <= 100; meditationHours++)
//    {
//        NSLog(@"I am getting more enlightened.");
//    }
    
    int strandOfWheat = 1;
    for (int i = 2; i <= 30; i++) {
        strandOfWheat = strandOfWheat * 2;
        NSLog(@"%i", strandOfWheat);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
