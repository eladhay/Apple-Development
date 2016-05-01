//
//  EHUserLogin.h
//  NSUserDefaults, Segues and Protocols Challenge Solution
//
//  Created by Elad Hayun on 7/25/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHUserLogin : NSObject

// Class Properties
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

// Class Methods
-(id)initWithData:(NSDictionary *)data;
+ (NSDictionary *) userLoginObjectAsPropertyList:(EHUserLogin *) userLoginObject;
+ (EHUserLogin *) userLoginObjectForDictionary:(NSDictionary *) dictionary;

@end
