//
//  EHHomeViewController.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHHomeViewController.h"
#import "EHProfileViewController.h"
#import "EHMatchViewController.h"
#import "EHTestUser.h"

@interface EHHomeViewController () <EHMatchViewControllerDelegate>

// IBOutlets

@property (strong, nonatomic) IBOutlet UIBarButtonItem *chatBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLineLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *dislikeButton;
@property (strong, nonatomic) IBOutlet UIView *labelContainerView;
@property (strong, nonatomic) IBOutlet UIView *buttonContainerView;

// Private Properties

@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) PFObject *photo;
@property (strong, nonatomic) NSMutableArray *activities;

@property (nonatomic) int currentPhotoIndex;
@property (nonatomic) BOOL isLikedByCurrentUser;
@property (nonatomic) BOOL isDislikedByCurrentUser;

@end

@implementation EHHomeViewController

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
	
	//[EHTestUser saveTestUserToParse];
	
	[self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
	self.photoImageView.image = nil;
	self.firstNameLabel.text = nil;
	self.ageLabel.text = nil;
	
	// Disable the view's buttons before we download the pictures.
	self.likeButton.enabled = false;
	self.dislikeButton.enabled = false;
	self.infoButton.enabled = false;
	
	// Reset the current photo index.
	self.currentPhotoIndex = 0;
	
	PFQuery *query = [PFQuery queryWithClassName:kEHPhotoClassKey];
	[query whereKey:kEHPhotoUserKey notEqualTo:[PFUser currentUser]];
	[query includeKey:kEHPhotoUserKey];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	 {
		 if (!error)
		 {
			 self.photos = objects;
			 
			 if ([self allowPhoto] == false)
			 {
				 [self setupNextPhoto];
			 }
			 else
			 {
				 [self queryForCurrentPhotoIndex];
			 }
		 }
		 else
		 {
			 NSLog(@"%@", error);
		 }
	 }];
}

- (void)setupViews
{
	self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
	[self addShadowForView:self.photoImageView];
	[self addShadowForView:self.buttonContainerView];
	[self addShadowForView:self.labelContainerView];
	self.photoImageView.layer.masksToBounds = true;
}

- (void)addShadowForView:(UIView *)view
{
	view.layer.masksToBounds = false;
	view.layer.cornerRadius = 4;
	view.layer.shadowRadius = 1;
	view.layer.shadowOffset = CGSizeMake(0, 1);
	view.layer.shadowOpacity = 0.25;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"homeToProfileSegue"])
	{
		EHProfileViewController *profileVC = segue.destinationViewController;
		profileVC.photo = self.photo;
	}
	else if ([segue.identifier isEqualToString:@"homeToMatchSegue"])
	{
		EHMatchViewController *matchVC = segue.destinationViewController;
		matchVC.matchedUserImage = self.photoImageView.image;
		matchVC.delegate = self;
	}
}

#pragma mark - IBActions

- (IBAction)settingsBarButtonItemPressed:(UIBarButtonItem *)sender
{
}

- (IBAction)chatBarButtonItemPressed:(UIBarButtonItem *)sender
{
}

- (IBAction)likeButtonPressed:(UIButton *)sender
{
	[self checkLike];
}

- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
	[self checkDislike];
}

- (IBAction)infoButtonPressed:(UIButton *)sender
{
	[self performSegueWithIdentifier:@"homeToProfileSegue" sender:nil];
}

#pragma mark - Helper Methods

- (void)queryForCurrentPhotoIndex
{
	if ([self.photos count] > 0)
	{
		self.photo = self.photos[self.currentPhotoIndex];
		PFFile *file = self.photo[kEHPhotoPictureKey];
		[file getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
		 {
			 if (!error)
			 {
				 UIImage *image = [UIImage imageWithData:data];
				 self.photoImageView.image = image;
				 [self updateView];
			 }
			 else
			 {
				 NSLog(@"%@", error);
			 }
		 }];
		
		PFQuery *queryForLike = [PFQuery queryWithClassName:kEHActivityClassKey];
		[queryForLike whereKey:kEHActivityTypeKey equalTo:kEHActivityTypeLikeKey];
		[queryForLike whereKey:kEHActivityPhotoKey equalTo:self.photo];
		[queryForLike whereKey:kEHActivityFromUserKey equalTo:[PFUser currentUser]];
		
		PFQuery *queryForDislike = [PFQuery queryWithClassName:kEHActivityClassKey];
		[queryForDislike whereKey:kEHActivityTypeKey equalTo:kEHActivityTypeDislikeKey];
		[queryForDislike whereKey:kEHActivityPhotoKey equalTo:self.photo];
		[queryForDislike whereKey:kEHActivityFromUserKey equalTo:[PFUser currentUser]];
		
		PFQuery *likeAndDislikeQuery = [PFQuery orQueryWithSubqueries:@[queryForLike, queryForDislike]];
		[likeAndDislikeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
		 {
			 if (!error)
			 {
				 self.infoButton.enabled = true;
				 self.activities = [objects mutableCopy];
				 if ([self.activities count] == 0)
				 {
					 self.likeButton.enabled = true;
					 self.dislikeButton.enabled = true;
					 self.isLikedByCurrentUser = false;
					 self.isDislikedByCurrentUser = false;
				 }
				 else
				 {
					 PFObject *activity = self.activities[0];
					 if ([activity[kEHActivityTypeKey] isEqualToString:kEHActivityTypeLikeKey])
					 {
						 self.likeButton.enabled = false;
						 self.dislikeButton.enabled = true;
						 self.isLikedByCurrentUser = true;
						 self.isDislikedByCurrentUser = false;
					 }
					 else if ([activity[kEHActivityTypeKey]isEqualToString:kEHActivityTypeDislikeKey])
					 {
						 self.likeButton.enabled = true;
						 self.dislikeButton.enabled = false;
						 self.isLikedByCurrentUser = false;
						 self.isDislikedByCurrentUser = true;
					 }
					 else
					 {
						 self.likeButton.enabled = true;
						 self.dislikeButton.enabled = true;
					 }
				 }
			 }
		 }];
	}
}

- (void)updateView
{
	self.firstNameLabel.text = self.photo[kEHPhotoUserKey][kEHUserProfileKey][kEHUserProfileFirstNameKey];
	self.ageLabel.text = [NSString stringWithFormat:@"%@", self.photo[kEHPhotoUserKey][kEHUserProfileKey][kEHUserProfileAgeKey]];
	self.tagLineLabel.text = self.photo[kEHPhotoUserKey][kEHUserTagLineKey];
}

- (void)setupNextPhoto
{
	if (self.currentPhotoIndex + 1 < self.photos.count)
	{
		self.currentPhotoIndex++;
		
		if ([self allowPhoto] == false)
		{
			[self setupNextPhoto];
		}
		else
		{
			[self queryForCurrentPhotoIndex];
		}
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No More Users to View" message:@"Check Back Later for More People" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	}
}

- (BOOL)allowPhoto
{
	int maxAge = [[NSUserDefaults standardUserDefaults] integerForKey:kEHAgeMaxKey];
	BOOL men = [[NSUserDefaults standardUserDefaults] boolForKey:kEHMenEnabledKey];
	BOOL women = [[NSUserDefaults standardUserDefaults] boolForKey:kEHWomenEnabledKey];
	BOOL singles = [[NSUserDefaults standardUserDefaults] boolForKey:kEHSinglesEnabledKey];
	
	PFObject *photo = self.photos[self.currentPhotoIndex];
	PFUser *user = photo[kEHPhotoUserKey];
	
	int userAge = [user[kEHUserProfileKey][kEHUserProfileAgeKey] intValue];
	NSString *gender = user[kEHUserProfileKey][kEHUserProfileGenderKey];
	NSString *relationshipStatus = user[kEHUserProfileKey][kEHUserProfileRelationshipStatusKey];
	
	if (userAge > maxAge)
	{
		return false;
	}
	else if ((men == false) && ([gender isEqualToString:@"male"]))
	{
		return false;
	}
	else if ((women == false) && ([gender isEqualToString:@"female"]))
	{
		return false;
	}
	else if ((singles == false) && (([relationshipStatus isEqualToString:@"single"]) || (relationshipStatus == nil)))
	{
		return false;
	}
	else
	{
		return true;
	}
}

- (void)saveLike
{
	PFObject *likeActivity = [PFObject objectWithClassName:kEHActivityClassKey];
	[likeActivity setObject:kEHActivityTypeLikeKey forKey:kEHActivityTypeKey];
	[likeActivity setObject:[PFUser currentUser] forKey:kEHActivityFromUserKey];
	[likeActivity setObject:[self.photo objectForKey:kEHPhotoUserKey] forKey:kEHActivityToUserKey];
	[likeActivity setObject:self.photo forKey:kEHActivityPhotoKey];
	[likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	 {
		 self.isLikedByCurrentUser = true;
		 self.isDislikedByCurrentUser = false;
		 [self.activities addObject:likeActivity];
		 [self checkForPhotoUserLikes];
		 [self setupNextPhoto];
	 }];
}

- (void)saveDislike
{
	PFObject *dislikeActivity = [PFObject objectWithClassName:kEHActivityClassKey];
	[dislikeActivity setObject:kEHActivityTypeDislikeKey forKey:kEHActivityTypeKey];
	[dislikeActivity setObject:[PFUser currentUser] forKey:kEHActivityFromUserKey];
	[dislikeActivity setObject:[self.photo objectForKey:kEHPhotoUserKey] forKey:kEHActivityToUserKey];
	[dislikeActivity setObject:self.photo forKey:kEHActivityPhotoKey];
	[dislikeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	 {
		 self.isLikedByCurrentUser = false;
		 self.isDislikedByCurrentUser = true;
		 [self.activities addObject:dislikeActivity];
		 [self setupNextPhoto];
	 }];
}

- (void)checkLike
{
	if (self.isLikedByCurrentUser)
	{
		[self setupNextPhoto];
		return;
	}
	else if (self.isDislikedByCurrentUser)
	{
		for (PFObject *activity in self.activities)
		{
			[activity deleteInBackground];
		}
		[self.activities removeLastObject];
		[self saveLike];
	}
	else
	{
		[self saveLike];
	}
}

- (void)checkDislike
{
	if (self.isDislikedByCurrentUser)
	{
		[self setupNextPhoto];
		return;
	}
	else if (self.isLikedByCurrentUser)
	{
		for (PFObject *activity in self.activities)
		{
			[activity deleteInBackground];
		}
		[self.activities removeLastObject];
		[self saveDislike];
	}
	else
	{
		[self saveDislike];
	}
}

- (void)checkForPhotoUserLikes
{
	PFQuery *query = [PFQuery queryWithClassName:kEHActivityClassKey];
	[query whereKey:kEHActivityFromUserKey equalTo:self.photo[kEHPhotoUserKey]];
	[query whereKey:kEHActivityToUserKey equalTo:[PFUser currentUser]];
	[query whereKey:kEHActivityTypeKey equalTo:kEHActivityTypeLikeKey];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	 {
		 if ([objects count] > 0)
		 {
			 // Create the chat room.
			 [self createChatRoom];
		 }
	 }];
}

- (void)createChatRoom
{
	PFQuery *queryForChatRoom = [PFQuery queryWithClassName:kEHChatRoomClassKey];
	[queryForChatRoom whereKey:kEHChatRoomUser1Key equalTo:[PFUser currentUser]];
	[queryForChatRoom whereKey:kEHChatRoomUser2Key equalTo:self.photo[kEHPhotoUserKey]];
	
	PFQuery *queryForChatRoomInverse = [PFQuery queryWithClassName:kEHChatRoomClassKey];
	[queryForChatRoomInverse whereKey:kEHChatRoomUser1Key equalTo:self.photo[kEHPhotoUserKey]];
	[queryForChatRoomInverse whereKey:kEHChatRoomUser2Key equalTo:[PFUser currentUser]];
	
	PFQuery *combinedQuery = [PFQuery orQueryWithSubqueries:@[queryForChatRoom, queryForChatRoomInverse]];
	[combinedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	 {
		 if ([objects count] == 0)
		 {
			 PFObject *chatRoom = [PFObject objectWithClassName:kEHChatRoomClassKey];
			 [chatRoom setObject:[PFUser currentUser] forKey:kEHChatRoomUser1Key];
			 [chatRoom setObject:self.photo[kEHPhotoUserKey] forKey:kEHChatRoomUser2Key];
			 [chatRoom saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
			  {
				  [self performSegueWithIdentifier:@"homeToMatchSegue" sender:nil];
			  }];
		 }
	 }];
}

#pragma mark - EHMatchViewController Delegate

- (void)presentMatchesViewController
{
	[self dismissViewControllerAnimated:true completion:^{
		[self performSegueWithIdentifier:@"homeToMatchesSegue" sender:nil];
	}];
}

@end
