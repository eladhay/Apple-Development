//
//  PiratesGameViewController.h
//  Pirates Game
//
//  Created by Elad Hayun on 7/19/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiratesGameFactory.h"

@interface PiratesGameViewController : UIViewController

@property (strong, nonatomic) PiratesGameFactory *piratesGameFactory;
@property (strong, nonatomic) PiratesGameTile *currentTile;
@property (strong, nonatomic) IBOutlet UILabel *heroStatsLabel;
@property (strong, nonatomic) IBOutlet UILabel *enemyStatsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *tileBackgroundImage;
@property (strong, nonatomic) IBOutlet UILabel *tileStoryLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonActionText;
@property (strong, nonatomic) IBOutlet UIButton *buttonUpText;
@property (strong, nonatomic) IBOutlet UIButton *buttonDownText;
@property (strong, nonatomic) IBOutlet UIButton *buttonRightText;
@property (strong, nonatomic) IBOutlet UIButton *buttonLeftText;
@property (strong, nonatomic) IBOutlet UITextView *progressLogTextView;

- (IBAction)resetGameButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)buttonUpPressed:(UIButton *)sender;
- (IBAction)buttonDownPressed:(UIButton *)sender;
- (IBAction)buttonRightPressed:(UIButton *)sender;
- (IBAction)buttonLeftPressed:(UIButton *)sender;
- (IBAction)buttonActionPressed:(UIBarButtonItem *)sender;

@end
