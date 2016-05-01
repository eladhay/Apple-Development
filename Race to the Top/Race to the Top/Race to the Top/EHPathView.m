//
//  EHPathView.m
//  Race to the Top
//
//  Created by Elad Hayun on 7/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHPathView.h"
#import "EHMountainPath.h"

@implementation EHPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    for (UIBezierPath *path in [EHMountainPath mountainPathsForRect:self.bounds]) {
        [path stroke];
    }
}

@end
