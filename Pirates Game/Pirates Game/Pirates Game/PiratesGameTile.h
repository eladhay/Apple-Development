//
//  PiratesGameTile.h
//  Pirates Game
//
//  Created by Elad Hayun on 7/19/14.
//  Copyright (c) 2014 Keydood. All rights reserved.

//  This class defines the model for the tile object

#import <Foundation/Foundation.h>
#import "PiratesGameEquipment.h"
#import "PiratesGameCharacter.h"

@interface PiratesGameTile : NSObject

// Declare all the required tile properties.

@property (nonatomic) BOOL isStartTile;
@property (nonatomic) BOOL isTileAllocated;
@property (nonatomic) int maximumCoordinateX;
@property (nonatomic) int maximumCoordinateY;
@property (nonatomic) CGPoint coordinates;
@property (strong, nonatomic) NSString* story;
@property (strong, nonatomic) UIImage* backgroundImage;
@property (strong, nonatomic) PiratesGameEquipment* availableItem;
@property (strong, nonatomic) PiratesGameCharacter* availableEnemy;
@property (strong, nonatomic) NSArray* availableActions;

// Declare all the required tile methods.



@end
