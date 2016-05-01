//
//  EHLoginViewController.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/19/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHLoginViewController.h"

@interface EHLoginViewController ()

// IBOutlets
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

// Properties
@property (strong, nonatomic) NSMutableData *imageData;

@end

@implementation EHLoginViewController

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
	
	// Hide the activity indicator.
	self.activityIndicator.hidden = true;
}

- (void)viewDidAppear:(BOOL)animated
{
	if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
	{
		[self updateUserInformation];
		[self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
	}
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

- (IBAction)loginButtonPressed:(UIButton *)sender
{
	// Show and animate the activity indicator.
	self.activityIndicator.hidden = false;
	[self.activityIndicator startAnimating];
	
	NSArray *permissionsArray = @[@"user_about_me", @"user_interests", @"user_relationships", @"user_birthday", @"user_location", @"user_relationship_details"];
	
	[PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error)
	{
		// Stop animating the activity indicator and hide it.
		[self.activityIndicator stopAnimating];
		self.activityIndicator.hidden = true;
		
		if (!user)
		{
			if (!error)
			{
				// No User and no error - The user canceled the facebook login window.
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"The Facebook Login was canceled" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
				
				// Show the alert after constructing it.
				[alertView show];
			}
			else
			{
				// There was an error - Show its description.
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
				
				// Show the alert after constructing it.
				[alertView show];
			}
		}
		else
		{
			// Update the user profile dictionary.
			[self updateUserInformation];
			
			// We got a user back - Transition to the logged in view.
			[self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
		}
	}];
}

#pragma mark - Helper Methods

- (void)updateUserInformation
{
	FBRequest *request = [FBRequest requestForMe];
	
	[request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
	{
		if (!error)
		{
			NSDictionary *userDictionary = (NSDictionary *)result;
			
			// create URL
			NSString *facebookID = userDictionary[@"id"];
			NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
			
			NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
			
			if (userDictionary[@"name"])
			{
				userProfile[kEHUserProfileNameKey] = userDictionary[@"name"];
			}
			
			if (userDictionary[@"first_name"])
			{
				userProfile[kEHUserProfileFirstNameKey] = userDictionary[@"first_name"];
			}
			
			if (userDictionary[@"location"][@"name"])
			{
				userProfile[kEHUserProfileLocationKey] = userDictionary[@"location"][@"name"];
			}
			
			if (userDictionary[@"gender"])
			{
				userProfile[kEHUserProfileGenderKey] = userDictionary[@"gender"];
			}
			
			if (userDictionary[@"birthday"])
			{
				// Save the user's birthday.
				userProfile[kEHUserProfileBirthdayKey] = userDictionary[@"birthday"];
				
				// Logic to convert birthday into age.
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateStyle:NSDateFormatterShortStyle];
				NSDate *date = [formatter dateFromString:userDictionary[@"birthday"]];
				NSDate *now = [NSDate date];
				NSTimeInterval seconds = [now timeIntervalSinceDate:date];
				int age = seconds / 31536000;
				userProfile[kEHUserProfileAgeKey] = @(age);
			}
			
			if (userDictionary[@"interested_in"])
			{
				userProfile[kEHUserProfileInterestedInKey] = userDictionary[@"interested_in"];
			}
			
			if (userDictionary[@"relationship_status"])
			{
				userProfile[kEHUserProfileRelationshipStatusKey] = userDictionary[@"relationship_status"];
			}
			
			if ([pictureURL absoluteString])
			{
				userProfile[kEHUserProfilePictureURL] = [pictureURL absoluteString];
			}
			
			[[PFUser currentUser] setObject:userProfile forKey:kEHUserProfileKey];
			[[PFUser currentUser] saveInBackground];
			[self requestImage];
		}
		else
		{
			NSLog(@"Error in FB request %@", error);
		}
	}];
}

- (void)uploadPFFileToParse:(UIImage *)image
{
	NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
	
	if (!imageData)
	{
		NSLog(@"imageData was not found");
		return;
	}
	
	PFFile *photoFile = [PFFile fileWithData:imageData];
	[photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (succeeded)
		{
			PFObject *photo = [PFObject objectWithClassName:kEHPhotoClassKey];
			[photo setObject:[PFUser currentUser] forKey:kEHPhotoUserKey];
			[photo setObject:photoFile forKey:kEHPhotoPictureKey];
			[photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
			{
				if (succeeded)
				{
					NSLog(@"Photo saved successfully");
				}
			}];
		}
	}];
}

- (void)requestImage
{
	PFQuery *query = [PFQuery queryWithClassName:kEHPhotoClassKey];
	[query whereKey:kEHPhotoUserKey equalTo:[PFUser currentUser]];
	
	[query countObjectsInBackgroundWithBlock:^(int number, NSError *error)
	{
		if (number == 0)
		{
			PFUser *user = [PFUser currentUser];
			self.imageData = [[NSMutableData alloc] init];
			
			NSURL *profilePictureURL = [NSURL URLWithString:user[kEHUserProfileKey][kEHUserProfilePictureURL]];
			NSURLRequest *urlRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
			NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
			
			if (!urlConnection)
			{
				NSLog(@"Failed to download picture.");
			}
		}
	}];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	UIImage *profileImage = [UIImage imageWithData:self.imageData];
	[self uploadPFFileToParse:profileImage];
}

@end
