//
//  EHViewController.m
//  Challenge 4 Methods
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHViewController.h"
#import "EHM.h"

@interface EHViewController ()

@end

@implementation EHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    EHM *myCustomObject = [[EHM alloc] init];
    //[myCustomObject printWholeNumbersBetweenFirstInteger:<#(int)#> andSecondInteger:<#(int)#>]
    //[myCustomObject printWholeNumbersInRange:1];
    NSLog(@"%i", [myCustomObject getFactorial:3]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
