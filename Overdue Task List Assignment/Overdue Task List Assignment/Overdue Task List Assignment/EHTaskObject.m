//
//  EHTaskObject.m
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHTaskObject.h"

@implementation EHTaskObject


// Override the default init method.
- (id)init
{
    self = [self initWithData:nil];
    return self;
}

// Create our own custom initializer.
- (id)initWithData:(NSDictionary *)data
{
    // Do the base class initiation first.
    self= [super init];
    
    // Now perform our own, custom initiation.
    self.taskTitle = data[TASK_TITLE];
    self.taskDescription = data[TASK_DESCRIPTION];
    self.taskDueDate = data[TASK_DATE];
    self.taskCompleted = [data[TASK_COMPLETION] boolValue];
    
    return self;
}

// Convert a single task object into a dictionary-based property list
+ (NSDictionary *) taskObjectAsPropertyList:(EHTaskObject *) taskObject
{
    NSDictionary *dictionary = @{
                                    TASK_TITLE:taskObject.taskTitle,
                                    TASK_DESCRIPTION:taskObject.taskDescription,
                                    TASK_DATE:taskObject.taskDueDate,
                                    TASK_COMPLETION:@(taskObject.taskCompleted)
                                };
    return dictionary;
}

// Convert a dictionary into an initialized task object.
+ (EHTaskObject *) taskObjectForDictionary:(NSDictionary *) dictionary
{
    EHTaskObject *taskObject = [[EHTaskObject alloc] initWithData:dictionary];
    return taskObject;
}

@end
