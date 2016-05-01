//
//  EHViewController.m
//  A View to the World
//
//  Created by Elad Hayun on 7/27/14.
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
    
//    NSLog(@"button 1 bounds size (%f, %f)", self.button1.bounds.size.height, self.button1.bounds.size.width);
//    NSLog(@"button 1 frame size (%f, %f)", self.button1.frame.size.height, self.button1.frame.size.width);
//    NSLog(@"button 1 bounds origin (%f, %f)", self.button1.frame.origin.x, self.button1.frame.origin.y);
//    NSLog(@"button 1 frame origin (%f, %f)", self.button1.frame.origin.x, self.button1.frame.origin.y);
//    NSLog(@"button 1 center (%f, %f)", self.button1.center.x, self.button1.center.y);
//    NSLog(@"view 1 bounds size (%f, %f)", self.view1.bounds.size.height, self.view1.bounds.size.width);
//    NSLog(@"view 1 frame size (%f, %f)", self.view1.frame.size.height, self.view1.frame.size.width);
//    NSLog(@"view 1 bounds origin (%f, %f)", self.view1.bounds.origin.x, self.view1.bounds.origin.y);
//    NSLog(@"view 1 frame origin (%f, %f)", self.view1.frame.origin.x, self.view1.frame.origin.y);
//    NSLog(@"view 1 center (%f, %f)", self.view1.center.x, self.view1.center.y);
//    NSLog(@"button 2 bounds size (%f, %f)", self.button2.bounds.size.height, self.button2.bounds.size.width);
//    NSLog(@"button 2 frame size (%f, %f)", self.button2.frame.size.height, self.button2.frame.size.width);
//    NSLog(@"button 2 bounds origin (%f, %f)", self.button2.bounds.origin.x, self.button2.bounds.origin.y);
//    NSLog(@"button 2 frame origin (%f, %f)", self.button2.frame.origin.x, self.button2.frame.origin.y);
//    NSLog(@"button 2 center (%f, %f)", self.button2.center.x, self.button2.center.y);
    
    // Create a frame and add a sub view to the top view.
    CGRect myViewsFrame = CGRectMake(20, 250, 200, 60);
    UIView *myView = [[UIView alloc] initWithFrame:myViewsFrame];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    // Add a ui button to the top view.
    UIButton *anotherButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    anotherButton.frame = CGRectMake(40, 40, 200, 100);
    anotherButton.backgroundColor = [UIColor greenColor];
    [anotherButton setTitle:@"Press me please" forState:UIControlStateNormal];
    [self.view addSubview:anotherButton];
    
    // Remove the sub view from the top view.
    [myView removeFromSuperview];
    
    // Create a target action and link it to our code created button.
    [anotherButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Buttons

// A method to handle the button pressed event. IBAction isn't required for non-storyboard elements and is typedef'd to void.
- (void)didPressButton:(UIButton *)button
{
    NSLog(@"Button Was Pressed!");
}

@end
