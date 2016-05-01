//
//  EHViewController.m
//  Passing Data Challenge Solution
//
//  Created by Elad Hayun on 7/22/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHViewController.h"
#import "EHDetailViewController.h"

@interface EHViewController ()

@end

@implementation EHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]])
    {
        if ([segue.destinationViewController isKindOfClass:[EHDetailViewController class]]) {
            EHDetailViewController *detailViewController  = segue.destinationViewController;
            detailViewController.textProxy = self.textField.text;
            detailViewController.delegate = self;
        }
    }
}

// Delegate Implementation
- (void) didUpdateText:(NSString *)text
{
    self.textField.text = text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performSegueWithIdentifier:@"Move On" sender:self.buttonNewPage];
    [self.textField resignFirstResponder];
    return true;
}

- (IBAction)buttonNewPagePressed:(UIButton *)sender {
}
@end
