//
//  EHHouseView.m
//  Drawing a House
//
//  Created by Elad Hayun on 7/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHHouseView.h"

@implementation EHHouseView

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
    // Drawing code for the house object.]
    // Create a new bezierpath object and assign it a line width of 2.0.
    UIBezierPath *houseBezierPath = [UIBezierPath bezierPath];
    houseBezierPath.lineWidth = 2.0;
    
    // Use the bezier path object and start drawing points.
    [houseBezierPath moveToPoint:CGPointMake(1/6.0 * self.bounds.size.width, 1/3.0 * self.bounds.size.height)];
    [houseBezierPath addLineToPoint:CGPointMake(1/6.0 * self.bounds.size.width, 2/3.0 * self.bounds.size.height)];
    [houseBezierPath addLineToPoint:CGPointMake(5/6.0 * self.bounds.size.width, 2/3.0 * self.bounds.size.height)];
    [houseBezierPath addLineToPoint:CGPointMake(5/6.0 * self.bounds.size.width, 1/3.0 * self.bounds.size.height)];
    
    // Connect our last point with the first point.
    [houseBezierPath closePath];
    
    [[UIColor grayColor] setFill];
    [houseBezierPath fill];
    
    // Do the actual line drawing.
    [houseBezierPath stroke];
    
    // Drawing code for the roof object.
    
    // Create a new bezierpath object and assign it a line width of 2.0.
    UIBezierPath *roofBezierPath = [UIBezierPath bezierPath];
    roofBezierPath.lineWidth = 2.0;
    
    NSLog(@"%f", 1/6.0 * self.bounds.size.width);
    NSLog(@"%f", 1/3.0 * self.bounds.size.height);
    // Use the bezier path object and start drawing points.
    [roofBezierPath moveToPoint:CGPointMake(0 * self.bounds.size.width, 1/3.0 * self.bounds.size.height)];
    [roofBezierPath addLineToPoint:CGPointMake(self.bounds.size.width, 1/3.0 * self.bounds.size.height)];
    [roofBezierPath addLineToPoint:CGPointMake(3/6.0 * self.bounds.size.width, 0 * self.bounds.size.height)];
    
    // Connect our last point with the first point.
    [roofBezierPath closePath];
    
    [[UIColor redColor] setFill];
    [roofBezierPath fill];
    
    // Do the actual line drawing.
    [roofBezierPath stroke];
    
    // Drawing code for the left house window.
    
    // Create a new bezierpath object and create it inside the previously created spaceship drawing.
    UIBezierPath *leftHouseWindowPath = [UIBezierPath bezierPathWithRect:CGRectMake(1/4.0 * self.bounds.size.width, 2/5.0 * self.bounds.size.height, 1/6.0 * self.bounds.size.width, 1/12.0 * self.bounds.size.height)];
    
    // Set the fill color to blue and color the above drawing.
    [[UIColor blueColor] setFill];
    [leftHouseWindowPath fill];
    [leftHouseWindowPath stroke];
    
    // Drawing code for the right house window.
    
    // Create a new bezierpath object and create it inside the previously created spaceship drawing.
    UIBezierPath *rightHouseWindowPath = [UIBezierPath bezierPathWithRect:CGRectMake(3/5.0 * self.bounds.size.width, 2/5.0 * self.bounds.size.height, 1/6.0 * self.bounds.size.width, 1/12.0 * self.bounds.size.height)];
    
    // Set the fill color to blue and color the above drawing.
    [[UIColor blueColor] setFill];
    [rightHouseWindowPath fill];
    [rightHouseWindowPath stroke];
    
    // Drawing code for the door of the house.
    
    // Create a new bezierpath object and create it inside the previously created spaceship drawing.
    UIBezierPath *houseDoorPath = [UIBezierPath bezierPathWithRect:CGRectMake(2.55/6.0 * self.bounds.size.width, 1.5/3.0 * self.bounds.size.height, 1/6.0 * self.bounds.size.width, 1/6.0 * self.bounds.size.height)];
    
    // Set the fill color to blue and color the above drawing.
    [[UIColor brownColor] setFill];
    [houseDoorPath fill];
    [houseDoorPath stroke];
    
    // Drawing code for the chimney of the house.
    
    // Create a new bezierpath object and create it inside the previously created spaceship drawing.
    UIBezierPath *houseChimneyPath = [UIBezierPath bezierPathWithRect:CGRectMake(1/6.0 * self.bounds.size.width, 1/10.0 * self.bounds.size.height, 1/6.0 * self.bounds.size.width, 1/6.0 * self.bounds.size.height)];
    
    // Set the fill color to blue and color the above drawing.
    [[UIColor blackColor] setFill];
    [houseChimneyPath fill];
    [houseChimneyPath stroke];
}

@end
