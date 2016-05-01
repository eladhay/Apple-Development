//
//  PiratesGameViewController.m
//  Pirates Game
//
//  Created by Elad Hayun on 7/19/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "PiratesGameViewController.h"

@interface PiratesGameViewController ()

@end

@implementation PiratesGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.piratesGameFactory = [PiratesGameFactory new];
    [self.piratesGameFactory initializeGame];
    [self setupStartTile];
    self.progressLogTextView.text = @"";
    [self updateCaptainsLog:@"Started new game"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupStartTile
{
    PiratesGameTile *startTile = [self.piratesGameFactory getStartTile];
    self.tileBackgroundImage.image = startTile.backgroundImage;
    self.tileStoryLabel.text = startTile.story;
    self.currentTile = startTile;
    [self configureTileView:nil];
}

- (void)configureTileView:(UIButton *)sender
{
    if (sender == self.buttonDownText)
    {
        [UIView transitionWithView:self.view duration:1.0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                self.tileBackgroundImage.image = self.currentTile.backgroundImage;
                self.tileStoryLabel.text = self.currentTile.story;
            } completion:^(BOOL finished) {
                nil;
            }];
    }
    else if (sender == self.buttonUpText)
    {
        [UIView transitionWithView:self.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            self.tileBackgroundImage.image = self.currentTile.backgroundImage;
            self.tileStoryLabel.text = self.currentTile.story;
        } completion:^(BOOL finished) {
            nil;
        }];
    }
    else if (sender == self.buttonLeftText)
    {
        [UIView transitionWithView:self.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.tileBackgroundImage.image = self.currentTile.backgroundImage;
            self.tileStoryLabel.text = self.currentTile.story;
        } completion:^(BOOL finished) {
            nil;
        }];
    }
    else if (sender == self.buttonRightText)
    {
        [UIView transitionWithView:self.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            self.tileBackgroundImage.image = self.currentTile.backgroundImage;
            self.tileStoryLabel.text = self.currentTile.story;
        } completion:^(BOOL finished) {
            nil;
        }];
    }
    
    [self configureAvailableDirections];
    [self configureAvailableActions];
}

- (void)configureAvailableDirections
{
    // NSLog(@"%f %f", self.currentTile.coordinates.x, self.currentTile.coordinates.y);
    
    if (self.currentTile.coordinates.y == [PiratesGameFactory getTileMaximumCoordinates].y)
    {
        self.buttonUpText.hidden = true;
    }
    else
    {
        self.buttonUpText.hidden = false;
    }
    
    if (self.currentTile.coordinates.y == 0)
    {
        self.buttonDownText.hidden = true;
    }
    else
    {
        self.buttonDownText.hidden = false;
    }
    
    if (self.currentTile.coordinates.x == [PiratesGameFactory getTileMaximumCoordinates].x)
    {
        self.buttonRightText.hidden = true;
    }
    else
    {
        self.buttonRightText.hidden = false;
    }
    
    if (self.currentTile.coordinates.x == 0)
    {
        self.buttonLeftText.hidden = true;
    }
    else
    {
        self.buttonLeftText.hidden = false;
    }
}

- (void)updateCaptainsLog:(NSString *)message
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    self.progressLogTextView.text = [self.progressLogTextView.text stringByAppendingString:[NSString stringWithFormat:@"\r\n%@ %@", dateString, message]];
    [self.progressLogTextView scrollRangeToVisible:NSMakeRange([self.progressLogTextView.text length], 0)];
}

- (void)configureAvailableActions
{
    // NSLog(@"%f %f", self.currentTile.coordinates.x, self.currentTile.coordinates.y);
}

- (IBAction)resetGameButtonPressed:(UIBarButtonItem *)sender
{
    self.progressLogTextView.text = @"";
    [self updateCaptainsLog:@"Started new game."];
    [self.piratesGameFactory initializeGame];
    [self setupStartTile];
}

- (IBAction)buttonUpPressed:(UIButton *)sender
{
    if (self.currentTile.coordinates.y != [PiratesGameFactory getTileMaximumCoordinates].y)
    {
        self.currentTile = [self.piratesGameFactory getTileAtPoint:CGPointMake(self.currentTile.coordinates.x, self.currentTile.coordinates.y + 1)];
        [self configureTileView:sender];
        [self updateCaptainsLog:@"Moved North."];
    }
}

- (IBAction)buttonDownPressed:(UIButton *)sender
{
    if (self.currentTile.coordinates.y != 0)
    {
        self.currentTile = [self.piratesGameFactory getTileAtPoint:CGPointMake(self.currentTile.coordinates.x, self.currentTile.coordinates.y - 1)];
        [self configureTileView:sender];
        [self updateCaptainsLog:@"Moved South."];
    }
}

- (IBAction)buttonRightPressed:(UIButton *)sender
{
    if (self.currentTile.coordinates.x != [PiratesGameFactory getTileMaximumCoordinates].x)
    {
        self.currentTile = [self.piratesGameFactory getTileAtPoint:CGPointMake(self.currentTile.coordinates.x + 1, self.currentTile.coordinates.y)];
        [self configureTileView:sender];
        [self updateCaptainsLog:@"Moved East."];
    }
}

- (IBAction)buttonLeftPressed:(UIButton *)sender
{
    if (self.currentTile.coordinates.x != 0)
    {
        self.currentTile = [self.piratesGameFactory getTileAtPoint:CGPointMake(self.currentTile.coordinates.x - 1, self.currentTile.coordinates.y)];
        [self configureTileView:sender];
        [self updateCaptainsLog:@"Moved West."];
    }
}

- (IBAction)buttonActionPressed:(UIBarButtonItem *)sender
{

}
@end
