//
//  EHConstants.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/24/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHConstants.h"

@implementation EHConstants

#pragma mark - User Class
NSString *const kEHUserTagLineKey					= @"tag_line";

NSString *const kEHUserProfileKey					= @"profile";
NSString *const kEHUserProfileNameKey				= @"name";
NSString *const kEHUserProfileFirstNameKey			= @"first_name";
NSString *const kEHUserProfileLocationKey			= @"location";
NSString *const kEHUserProfileGenderKey				= @"gender";
NSString *const kEHUserProfileBirthdayKey			= @"birthday";
NSString *const kEHUserProfileInterestedInKey		= @"interested_in";
NSString *const kEHUserProfilePictureURL			= @"picture_url";
NSString *const kEHUserProfileRelationshipStatusKey = @"relationship_status";
NSString *const kEHUserProfileAgeKey				= @"age";

#pragma mark - Photo Class

NSString *const kEHPhotoClassKey					= @"Photo";
NSString *const kEHPhotoUserKey						= @"user";
NSString *const kEHPhotoPictureKey					= @"image";

#pragma mark - Activity Class

NSString *const kEHActivityClassKey					= @"Activity";
NSString *const kEHActivityTypeKey					= @"type";
NSString *const kEHActivityFromUserKey				= @"fromUser";
NSString *const kEHActivityToUserKey				= @"toUser";
NSString *const kEHActivityPhotoKey					= @"photo";
NSString *const kEHActivityTypeLikeKey				= @"like";
NSString *const kEHActivityTypeDislikeKey			= @"dislike";

#pragma mark - Settings

NSString *const kEHMenEnabledKey					= @"men";
NSString *const kEHWomenEnabledKey					= @"women";
NSString *const kEHSinglesEnabledKey				= @"singles";
NSString *const kEHAgeMaxKey						= @"ageMax";

#pragma mark - ChatRoom

NSString *const kEHChatRoomClassKey					= @"ChatRoom";
NSString *const kEHChatRoomUser1Key					= @"user1";
NSString *const kEHChatRoomUser2Key					= @"user2";

#pragma mark - Chat

NSString *const kEHChatClassKey						=@"Chat";
NSString *const kEHChatChatRoomKey					=@"chatRoom";
NSString *const kEHChatFromUserKey					=@"fromUser";
NSString *const kEHChatToUserKey					=@"toUser";
NSString *const kEHChatTextKey						=@"text";
NSString *const kEHChatRoomCreatedAtKey				=@"createdAt";


@end
