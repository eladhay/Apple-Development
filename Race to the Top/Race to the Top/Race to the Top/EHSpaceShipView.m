//
//  EHSpaceShipView.m
//  Race to the Top
//
//  Created by Elad Hayun on 7/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHSpaceShipView.h"

@implementation EHSpaceShipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code for the spaceship object.
    
    // Create a new bezierpath object and assign it a line width of 2.0.
    UIBezierPath *spaceshipBezierPath = [UIBezierPath bezierPath];
    spaceshipBezierPath.lineWidth = 2.0;
    
    // Use the bezier path object and start drawing points.
    [spaceshipBezierPath moveToPoint:CGPointMake(1/6.0 * self.bounds.size.width, 1/3.0 * self.bounds.size.height)];
    [spaceshipBezierPath addLineToPoint:CGPointMake(1/6.0 * self.bounds.size.width, 2/3.0 * self.bounds.size.height)];
    [spaceshipBezierPath addLineToPoint:CGPointMake(5/6.0 * self.bounds.size.width, 2/3.0 * self.bounds.size.height)];
    [spaceshipBezierPath addLineToPoint:CGPointMake(2/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height)];
    [spaceshipBezierPath addLineToPoint:CGPointMake(1/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height)];
    
    // Connect our last point with the first point.
    [spaceshipBezierPath closePath];
    
    // Do the actual line drawing.
    [spaceshipBezierPath stroke];
    
    // Drawing code for the cockpit part of the spaceship.
    
    // Create a new bezierpath object and create it inside the previously created spaceship drawing.
    UIBezierPath *cockpitWindowPath = [UIBezierPath bezierPathWithRect:CGRectMake(2/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height, 1/6.0 * self.bounds.size.width, 1/12.0 * self.bounds.size.height)];
    
    // Set the fill color to blue and color the above drawing.
    [[UIColor blueColor] setFill];
    [cockpitWindowPath fill];
    
    // Do the actual line drawing.
}











@end
