//
//  PiratesGameFactory.m
//  Pirates Game
//
//  Created by Elad Hayun on 7/19/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "PiratesGameFactory.h"

@implementation PiratesGameFactory

// Return the maximum coordinates range for the game board.
+ (CGPoint) getTileMaximumCoordinates
{
    const int maximumCoordinateX = 3;
    const int maximumCoordinateY = 2;
    
    CGPoint result;
    result.x = maximumCoordinateX;
    result.y = maximumCoordinateY;
    
    return result;
}

//A class variable used to create and return a new tile object.
+ (PiratesGameTile*)createNewTileAt:(float)tileCoordinateX AndAt:(float)tileCoordinateY WithStory:(NSString*)tileStory WithImage:(UIImage*)tileBackgroundImage WithItem:(PiratesGameEquipment*)tileAvailableItem WithEnemy:(PiratesGameCharacter*)tileAvailableEnemy AndWithActions:(NSArray*)tileAvailableActions WhichIsTheStartTile:(BOOL)tileIsStart
{
    PiratesGameTile *newGameTile = [PiratesGameTile new];
    newGameTile.maximumCoordinateX = [self getTileMaximumCoordinates].x;
    newGameTile.maximumCoordinateY = [self getTileMaximumCoordinates].y;
    newGameTile.coordinates = CGPointMake(tileCoordinateX, tileCoordinateY);
    newGameTile.story = tileStory;
    newGameTile.backgroundImage = tileBackgroundImage;
    newGameTile.availableItem = tileAvailableItem;
    newGameTile.availableEnemy = tileAvailableEnemy;
    newGameTile.availableActions = tileAvailableActions;
    newGameTile.isStartTile = tileIsStart;
    newGameTile.isTileAllocated = false;
    return newGameTile;
}

// Will be used at the beginning of the game to create all the required game objects.
- (void)initializeGame
{
    [self createGameTiles];
    [self populateBoardGame];
}

- (PiratesGameTile*)getStartTile
{
    PiratesGameTile *startTile;
    
    for (PiratesGameTile *singleTile in self.boardGameTiles) {
        if (singleTile.isStartTile)
        {
            startTile = singleTile;
            break;
        }
    }
    
    return startTile;
}

- (PiratesGameTile*)getTileAtPoint:(CGPoint)tilePoint
{
    PiratesGameTile *requestedTile;
    
    for (PiratesGameTile *singleTile in self.boardGameTiles) {
        if (CGPointEqualToPoint(singleTile.coordinates, tilePoint))
        {
            requestedTile = singleTile;
            break;
        }
    }
    
    return requestedTile;
}

// Arrange all the game tiles.
- (void)populateBoardGame
{
    //Shuffle all the available tiles.
    [self shuffleGameTiles];
    
    //Initialize the boardGameTiles array.
    self.boardGameTiles = [NSMutableArray new];
    
    int tileCount = 0;
    
    for (int i = 0; i <= ([PiratesGameFactory getTileMaximumCoordinates].x); i++) {
        
        for (int j = 0; j <= ([PiratesGameFactory getTileMaximumCoordinates].y); j++) {
            
            PiratesGameTile *randomTile = [self.boardGameAvailableTiles objectAtIndex:tileCount];
            randomTile.coordinates = CGPointMake(i, j);
            randomTile.isTileAllocated = true;
            [self.boardGameTiles addObject:randomTile];
            tileCount++;
        }
    }
}

- (void)createGameTiles
{
    //Initialize the boardGameAvailableTiles array.
    self.boardGameAvailableTiles = [NSMutableArray new];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Start" WithImage:[UIImage imageNamed:@"PirateStart.jpg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:true]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Attack" WithImage:[UIImage imageNamed:@"PirateAttack.jpg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Black Smith" WithImage:[UIImage imageNamed:@"PirateBlacksmith.jpeg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Booty" WithImage:[UIImage imageNamed:@"PirateBooty.jpeg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Boss" WithImage:[UIImage imageNamed:@"PirateBoss.jpeg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Friendly Dock" WithImage:[UIImage imageNamed:@"PirateFriendlyDock.jpg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Octopus Attack" WithImage:[UIImage imageNamed:@"PirateOctopusAttack.jpg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Parrot" WithImage:[UIImage imageNamed:@"PirateParrot.jpg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Plank" WithImage:[UIImage imageNamed:@"PiratePlank.jpg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Ship Battle" WithImage:[UIImage imageNamed:@"PirateShipBattle.jpeg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Treasure" WithImage:[UIImage imageNamed:@"PirateTreasure.jpeg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
    
    [self.boardGameAvailableTiles addObject: [PiratesGameFactory createNewTileAt:0 AndAt:0 WithStory:@"Pirate Weapons" WithImage:[UIImage imageNamed:@"PirateWeapons.jpeg"] WithItem:nil WithEnemy:nil AndWithActions:nil WhichIsTheStartTile:false]];
}

- (void)shuffleGameTiles
{
    int tileCount = [self.boardGameAvailableTiles count];
    for (int i = 0; i < tileCount; ++i) {
        int remainingTileCount = tileCount - i;
        int exchangeTileIndex = i + arc4random_uniform(remainingTileCount);
        [self.boardGameAvailableTiles exchangeObjectAtIndex:i withObjectAtIndex:exchangeTileIndex];
    }
}

@end
