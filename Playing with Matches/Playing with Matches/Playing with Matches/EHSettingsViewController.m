//
//  EHSettingsViewController.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHSettingsViewController.h"

@interface EHSettingsViewController ()

@property (strong, nonatomic) IBOutlet UISlider *ageSlider;
@property (strong, nonatomic) IBOutlet UISwitch *menSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *womenSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *singlesSwitch;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UIButton *editProfileButton;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation EHSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.ageSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:kEHAgeMaxKey];
	self.menSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kEHMenEnabledKey];
	self.womenSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kEHWomenEnabledKey];
	self.singlesSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kEHSinglesEnabledKey];
	
	[self.ageSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
	[self.menSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
	[self.womenSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
	[self.singlesSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
	
	self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBActions

- (IBAction)logoutButtonPressed:(UIButton *)sender
{
	[PFUser logOut];
	[self.navigationController popToRootViewControllerAnimated:true];
}

- (IBAction)editProfileButtonPressed:(UIButton *)sender
{
}

#pragma mark - Helper Methods

- (void)valueChanged:(id)sender
{
	if (sender == self.ageSlider)
	{
		[[NSUserDefaults standardUserDefaults] setInteger:(int)self.ageSlider.value forKey:kEHAgeMaxKey];
		self.ageLabel.text = [NSString stringWithFormat:@"%i", (int)self.ageSlider.value];
	}
	else if (sender == self.menSwitch)
	{
		[[NSUserDefaults standardUserDefaults] setBool:self.menSwitch.isOn forKey:kEHMenEnabledKey];
	}
	else if (sender == self.womenSwitch)
	{
		[[NSUserDefaults standardUserDefaults] setBool:self.womenSwitch.isOn forKey:kEHWomenEnabledKey];
	}
	else if (sender == self.singlesSwitch)
	{
		[[NSUserDefaults standardUserDefaults] setBool:self.singlesSwitch.isOn forKey:kEHSinglesEnabledKey];
	}
	
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
