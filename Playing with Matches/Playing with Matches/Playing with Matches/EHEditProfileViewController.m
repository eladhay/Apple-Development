//
//  EHEditProfileViewController.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHEditProfileViewController.h"

@interface EHEditProfileViewController ()

@property (strong, nonatomic) IBOutlet UITextView *tagLineTextView;
@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;

@end

@implementation EHEditProfileViewController

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
	
	PFQuery *query =[PFQuery queryWithClassName:kEHPhotoClassKey];
	[query whereKey:kEHPhotoUserKey equalTo:[PFUser currentUser]];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if ([objects count] > 0)
		{
			PFObject *photo = objects[0];
			PFFile *pictureFile = photo[kEHPhotoPictureKey];
			[pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
			{
				self.profilePictureImageView.image = [UIImage imageWithData:data];
			}];
		}
	}];
	
	self.tagLineTextView.text = [[PFUser currentUser] objectForKey:kEHUserTagLineKey];
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

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender
{
	[[PFUser currentUser] setObject:self.tagLineTextView.text forKey:kEHUserTagLineKey];
	[[PFUser currentUser] saveInBackground];
	[self.navigationController popViewControllerAnimated:true];
}

@end
