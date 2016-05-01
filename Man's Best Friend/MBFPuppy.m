//
//  MBFPuppy.m
//  Man's Best Friend
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "MBFPuppy.h"

@implementation MBFPuppy

-(void)givePuppyEyes
{
    NSLog(@":(");
}

-(void)bark
{
    [super bark];
    NSLog(@"Whimper.... Whimper...");
    [self givePuppyEyes];
}

@end
