//
//  EHViewController.m
//  View Objects in Code
//
//  Created by Elad Hayun on 7/27/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHViewController.h"

@interface EHViewController ()

@property (strong, nonatomic) UILabel *myLabel;
@property (strong, nonatomic) UITextField *myTextField;
@end

@implementation EHViewController

#pragma mark - View Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add a UILabel in code.
    CGRect myLabelFrame = CGRectMake(20, 60, 280, 22);
    self.myLabel = [[UILabel alloc] initWithFrame:myLabelFrame];
    self.myLabel.text = @"My Label from Code";
    self.myLabel.backgroundColor = [UIColor redColor];
    self.myLabel.textColor = [UIColor whiteColor];
    
    // Add a UITextField in code.
    CGRect myTextFieldFrame = CGRectMake(20, 110, 280, 30);
    self.myTextField = [[UITextField alloc] initWithFrame:myTextFieldFrame];
    self.myTextField.placeholder = @"Hello There!";
    self.myTextField.backgroundColor = [UIColor lightGrayColor];
    
    // Add a UIButton in code.
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(20, 160, 280, 30);
    [myButton setTitle:@"Press Me!" forState:UIControlStateNormal];
    
    // Create a target action and link it to our code created button.
    [myButton addTarget:self action:@selector(didPressMyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the items to the view controller's top view.
    [self.view addSubview:self.myLabel];
    [self.view addSubview:self.myTextField];
    [self.view addSubview:myButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Buttons

// A method to handle the button pressed event. IBAction isn't required for non-storyboard elements and is typedef'd to void.
- (void)didPressMyButton:(UIButton *)button
{
    self.myLabel.text = self.myTextField.text;
    [self.myTextField resignFirstResponder];
}

@end
