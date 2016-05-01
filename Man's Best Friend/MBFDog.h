//
//  MBFDog.h
//  Man's Best Friend
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBFDog : NSObject

@property (nonatomic) int age;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *breed;
@property (nonatomic, strong) UIImage *image;



+(MBFDog*)createNewDogAged:(int)dogAge Named:(NSString*)dogName Breed:(NSString*)dogBreed withImage:(UIImage*)dogImage;
-(void)bark;
-(void)barkANumberOfTimes:(int)numberOfTimes;
-(void)changeBreedToWerewolf;
-(void)changeBreed:(NSString*)breedName;
-(void)barkANumberOfTimes:(int)numberOfTimes loudly:(BOOL)isLoud;
-(int)ageInHumanYearsFromAge:(int)dogYears;

@end
