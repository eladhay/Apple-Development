//
//  PiratesGameFactory.h
//  Pirates Game
//
//  Created by Elad Hayun on 7/19/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PiratesGameTile.h"
#import "PiratesGameAction.h"

@interface PiratesGameFactory : NSObject

// Declare all the required tile properties.

@property (strong, nonatomic) NSMutableArray* boardGameTiles;
@property (strong, nonatomic) NSMutableArray* boardGameAvailableTiles;
@property (strong, nonatomic) NSMutableArray* boardGameBackgroundImages;
@property (strong, nonatomic) NSMutableArray* boardGameItems;
@property (strong, nonatomic) NSMutableArray* boardGameEnemies;
@property (strong, nonatomic) NSMutableArray* boardGameStories;
@property (strong, nonatomic) NSMutableArray* boardGameActions;

// Declare all the required class/static methods.
+ (PiratesGameTile*)createNewTileAt:(float)tileCoordinateX AndAt:(float)tileCoordinateY WithStory:(NSString*)tileStory WithImage:(UIImage*)tileBackgroundImage WithItem:(PiratesGameEquipment*)tileAvailableItem WithEnemy:(PiratesGameCharacter*)tileAvailableEnemy AndWithActions:(NSArray*)tileAvailableActions WhichIsTheStartTile:(BOOL)tileIsStart;

+ (CGPoint)getTileMaximumCoordinates;

// Declare all the required instance methods.
- (void)initializeGame;
- (PiratesGameTile*)getStartTile;
- (PiratesGameTile*)getTileAtPoint:(CGPoint)tilePoint;

@end
