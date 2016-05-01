//
//  EHMountainPath.h
//  Race to the Top
//
//  Created by Elad Hayun on 7/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHMountainPath : NSObject

+ (NSArray *)mountainPathsForRect:(CGRect)rect;

+ (UIBezierPath *)tapTargetForPath:(UIBezierPath *)path;

@end
