//
//  EHUserLogin.m
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Elad Hayun on 7/25/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHUserLogin.h"

@implementation EHUserLogin

-(id)init
{
    self = [self initWithData:nil];
    return self;
}

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    self.username = data[USER_NAME];
    self.password = data[USER_PASSWORD];
    
    return self;
}

+ (NSDictionary *) userLoginObjectAsPropertyList:(EHUserLogin *) userLoginObject
{
    NSDictionary *dictionary = @{
                                 USER_NAME: userLoginObject.username,
                                 USER_PASSWORD: userLoginObject.password};
    
    return dictionary;
}

+ (EHUserLogin *) userLoginObjectForDictionary:(NSDictionary *) dictionary
{
    EHUserLogin *userLoginObject = [[EHUserLogin alloc] initWithData:dictionary];
    return userLoginObject;
}

@end
