//
//  EHViewController.m
//  99 Sodas
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
    
    for (int bottlesOfSoda = 99; bottlesOfSoda >= 0; bottlesOfSoda--) {
        if (bottlesOfSoda != 0){
            NSLog(@"%i bottles of soda on the wall, %i bottles of soda. If one of the bottles should happen to fall, %i bottls of soda on the wall.", bottlesOfSoda, bottlesOfSoda, bottlesOfSoda - 1);
        }
        else{
            NSLog(@"%i bottles of soda on the wall, %i bottles of soda. none one of the bottles should happen to fall because there are %i bottls of soda on the wall.", bottlesOfSoda, bottlesOfSoda, bottlesOfSoda);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
