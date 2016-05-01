//
//  EHConstants.h
//  Playing with Matches
//
//  Created by Elad Hayun on 8/24/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHConstants : NSObject

#pragma mark - User Class

extern NSString *const kEHUserTagLineKey;

extern NSString *const kEHUserProfileKey;
extern NSString *const kEHUserProfileNameKey;
extern NSString *const kEHUserProfileFirstNameKey;
extern NSString *const kEHUserProfileLocationKey;
extern NSString *const kEHUserProfileGenderKey;
extern NSString *const kEHUserProfileBirthdayKey;
extern NSString *const kEHUserProfileInterestedInKey;
extern NSString *const kEHUserProfilePictureURL;
extern NSString *const kEHUserProfileRelationshipStatusKey;
extern NSString *const kEHUserProfileAgeKey;

#pragma mark - Photo Class

extern NSString *const kEHPhotoClassKey;
extern NSString *const kEHPhotoUserKey;
extern NSString *const kEHPhotoPictureKey;

#pragma mark - Activity Class

extern NSString *const kEHActivityClassKey;
extern NSString *const kEHActivityTypeKey;
extern NSString *const kEHActivityFromUserKey;
extern NSString *const kEHActivityToUserKey;
extern NSString *const kEHActivityPhotoKey;
extern NSString *const kEHActivityTypeLikeKey;
extern NSString *const kEHActivityTypeDislikeKey;

#pragma mark - Settings

extern NSString *const kEHMenEnabledKey;
extern NSString *const kEHWomenEnabledKey;
extern NSString *const kEHSinglesEnabledKey;
extern NSString *const kEHAgeMaxKey;

#pragma mark - ChatRoom

extern NSString *const kEHChatRoomClassKey;
extern NSString *const kEHChatRoomUser1Key;
extern NSString *const kEHChatRoomUser2Key;

#pragma mark - Chat

extern NSString *const kEHChatClassKey;
extern NSString *const kEHChatChatRoomKey;
extern NSString *const kEHChatFromUserKey;
extern NSString *const kEHChatToUserKey;
extern NSString *const kEHChatTextKey;
extern NSString *const kEHChatRoomCreatedAtKey;

@end
