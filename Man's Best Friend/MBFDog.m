//
//  MBFDog.m
//  Man's Best Friend
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "MBFDog.h"

@implementation MBFDog

+(MBFDog*)createNewDogAged:(int)dogAge Named:(NSString*)dogName Breed:(NSString*)dogBreed withImage:(UIImage*)dogImage
{
    //Instantiate our dog object.
    MBFDog *newDog = [[MBFDog alloc] init];
    newDog.age = dogAge;
    newDog.name = dogName;
    newDog.breed = dogBreed;
    newDog.image = dogImage;
    return newDog;
}

-(void)bark
{
    NSLog(@"Woof Woof!");
}

-(void)barkANumberOfTimes:(int)numberOfTimes
{
    for (int bark = 1; bark <= numberOfTimes; bark++)
    {
        [self bark];
    }
}

-(void)changeBreed:(NSString*)breedName
{
    self.breed = breedName;
}

-(void)changeBreedToWerewolf
{
    [self changeBreed:@"Werewolf"];
}

-(void)barkANumberOfTimes:(int)numberOfTimes loudly:(BOOL)isLoud
{
    if (!isLoud)
    {
        for (int bark = 1; bark <= numberOfTimes; bark++)
        {
            NSLog(@"Yip Yip...");
        }
    }
    else
    {
        for (int bark = 1; bark <= numberOfTimes; bark++)
        {
            NSLog(@"Ruff Ruff!");
        }
    }
}

-(int)ageInHumanYearsFromAge:(int)dogYears
{
    int humanYears;
    
    if (dogYears > 2) {
        humanYears = (10.5 * 2) + ((dogYears - 2) * 4);
    }
    else {
        humanYears = 10.5 * dogYears;
    }
    
    return humanYears;
}

@end
