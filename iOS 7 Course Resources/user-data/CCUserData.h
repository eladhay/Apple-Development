//
//  CCUserData.h
//  User Data Challenge Solution
//
//  Created by Eliot Arntz on 10/19/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Each time the computer program comes across USER_NAME, USER_EMAIL and etc. it will replace it with the string next to the name. This adds consistency to our code since we'll be able to use USER_NAME instead of having to write out @"username over and over" */
#define USER_NAME @"username"
#define USER_EMAIL @"email"
#define USER_PASSWORD @"password"
#define USER_AGE @"age"
#define USER_PROFILE_PICTURE @"profilePicture"

@interface CCUserData : NSObject

/* A class method named users that returns an NSArray */
+(NSArray *)users;

@end
