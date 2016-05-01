//
//  TWCoreDataHelper.m
//  Thousand Words
//
//  Created by Elad Hayun on 7/29/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "TWCoreDataHelper.h"

@implementation TWCoreDataHelper

+ (NSManagedObjectContext *)managedObjectContext
{
    // Create a new deallocated context object.
    NSManagedObjectContext *context = nil;
    
    // Get our application's delegate and use it to retreive the managedObjectContext and gain access to core data.
    id delegate = [[UIApplication sharedApplication] delegate];
    
    // Make sure our application's delegate is valid and knows about core data.
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        // Return the app's managed object context.
        context = [delegate managedObjectContext];
    }
    
    // Return our application's core data context.
    return context;
}

@end
