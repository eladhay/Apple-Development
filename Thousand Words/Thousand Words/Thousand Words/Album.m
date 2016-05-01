//
//  Album.m
//  Thousand Words
//
//  Created by Elad Hayun on 7/29/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "Album.h"
#import "Photo.h"


@implementation Album

@dynamic date;
@dynamic name;
@dynamic photos;

+ (Album *)albumWithName:(NSString *)name
{
    // Get our application's delegate and use it to retreive the managedObjectContext and gain access to core data.
    NSManagedObjectContext *context = [TWCoreDataHelper managedObjectContext];
    
    // Create a new object entity of Album in core data, set its name and date.
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    // Create an empty error object and use it to catch the save error, if there was one.
    NSError *error = nil;
    if (![context save:&error])
    {
        //We have an error.
        NSLog(@"%@", error);
    }
    
    // Return our album object.
    return album;
}

@end
