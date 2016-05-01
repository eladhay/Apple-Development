//
//  EHTaskObject.h
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHTaskObject : NSObject

// Class Properties
@property (strong, nonatomic) NSString *taskTitle;
@property (strong, nonatomic) NSString *taskDescription;
@property (strong, nonatomic) NSDate *taskDueDate;
@property (nonatomic) BOOL taskCompleted;

// Class Methods
- (id)initWithData:(NSDictionary *)data;
+ (NSDictionary *) taskObjectAsPropertyList:(EHTaskObject *) taskObject;
+ (EHTaskObject *) taskObjectForDictionary:(NSDictionary *) dictionary;

@end
