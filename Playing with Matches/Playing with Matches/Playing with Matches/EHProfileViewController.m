//
//  EHProfileViewController.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHProfileViewController.h"

@interface EHProfileViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLineLabel;

@end

@implementation EHProfileViewController

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
	
	PFFile *pictureFile = self.photo[kEHPhotoPictureKey];
	[pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
	{
		self.profilePictureImageView.image = [UIImage imageWithData:data];
	}];
	
	PFUser *user = self.photo[kEHPhotoUserKey];
	self.locationLabel.text = user[kEHUserProfileKey][kEHUserProfileLocationKey];
	self.ageLabel.text = [NSString stringWithFormat:@"%@", user[kEHUserProfileKey][kEHUserProfileAgeKey]];
	self.statusLabel.text = user[kEHUserProfileKey][kEHUserProfileRelationshipStatusKey];
	self.tagLineLabel.text = user[kEHUserTagLineKey];
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

- (IBAction)likeButtonPressed:(UIButton *)sender
{
	
}

- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
	
}

@end
