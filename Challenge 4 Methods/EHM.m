//
//  EHM.m
//  Challenge 4 Methods
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHM.h"

@implementation EHM

-(void)printWholeNumbersInRange:(int)range;
{
    if (range > 0)
    {
        NSLog(@"The number specified was smaller than or equal to zero.");
        return;
    }
    
    for (int i = range; i >= 1; i--)
    {
        NSLog(@"%i", i);
    }
}

-(void)printWholeNumbersBetweenFirstInteger:(int)firstInteger andSecondInteger:(int)secondInteger
{
    if (firstInteger == secondInteger)
    {
        NSLog(@"The ranges specified are equal!");
    }
    else if (firstInteger > secondInteger)
    {
        for (int i = firstInteger; i >= secondInteger; i--)
        {
            NSLog(@"%i", i);
        }
    }
    else
    {
        for (int i = secondInteger; i >= firstInteger; i--)
        {
            NSLog(@"%i", i);
        }
    }
}

-(int)getFactorial:(int)number
{
    int result = number;
    
    for (int i = number; i > 1; i--) {
        result = result * (i - 1);
    }
    
    return result;
}

@end
