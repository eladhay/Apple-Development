//
//  CCUserData.m
//  User Data Challenge Solution
//
//  Created by Eliot Arntz on 10/19/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "CCUserData.h"

@implementation CCUserData

+(NSArray *)users
{
    /* To create an NSDictionary we use the literal syntax with curly braces. Remember that NSDictionaries are created in key-value pairs.*/
    NSDictionary *user1 = @{USER_NAME : @"master photographer", USER_EMAIL : @"worldtraveler1@me.com", USER_PASSWORD : @"drowssap", USER_AGE : @24, USER_PROFILE_PICTURE : [UIImage imageNamed:@"person1.jpeg"]};
    
    NSDictionary *user2 = @{USER_NAME : @"Lots of tots", USER_EMAIL: @"otterskips2@me.com", USER_PASSWORD : @"icecreamrocks", USER_AGE : @65, USER_PROFILE_PICTURE : [UIImage imageNamed:@"person2.jpeg"]};
    
    NSDictionary *user3 = @{USER_NAME: @"iTechie", USER_EMAIL : @"theRealApple@me.com", USER_PASSWORD : @"infiniteloop", USER_AGE : @30, USER_PROFILE_PICTURE : [UIImage imageNamed:@"person3.jpg"]};
    
    NSDictionary *user4 = @{USER_NAME : @"Royal", USER_EMAIL : @"king@me.com", USER_PASSWORD : @"IGotAPalace", USER_AGE : @0, USER_PROFILE_PICTURE : [UIImage imageNamed:@"person4.jpeg"]};
    
    /* To create an NSArray we use the literal syntax with brackets. Remember that NSArrays contain objects. Using literal syntax we do not need to add nil at the end! */
    NSArray *usersArray = @[user1, user2, user3, user4];
    
    /* Return an NSArray of NSDictionaries from this class method */
    return usersArray;
}

@end
