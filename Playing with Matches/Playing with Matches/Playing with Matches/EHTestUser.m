//
//  EHTestUser.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHTestUser.h"

@implementation EHTestUser

+ (void)saveTestUserToParse
{
	PFUser *newUser = [PFUser user];
	newUser.username = @"user1";
	newUser.password = @"password1";
	
	[newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
	{
		if (!error)
		{
			NSDictionary *profile = @{kEHUserProfileAgeKey : @28, kEHUserProfileBirthdayKey : @"11/22/1985", kEHUserProfileFirstNameKey : @"julie", kEHUserProfileGenderKey : @"female", kEHUserProfileLocationKey : @"Berlin, Germany", kEHUserProfileNameKey : @"Julie Adams"};
			[newUser setObject:profile forKey:kEHUserProfileKey];
			[newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
			{
				UIImage *profileImage = [UIImage imageNamed:@"JulieAdams.jpg"];
				NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
				
				PFFile *photoFile = [PFFile fileWithData:imageData];
				[photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
				{
					if (succeeded)
					{
						PFObject *photo = [PFObject objectWithClassName:kEHPhotoClassKey];
						[photo setObject:newUser forKey:kEHPhotoUserKey];
						[photo setObject:photoFile forKey:kEHPhotoPictureKey];
						[photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
						{
							NSLog(@"photo saved successfully");
						}];
					}
				}];
			}];
		}
	}];
}

@end
