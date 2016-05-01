//
//  EHViewController.m
//  Race to the Top
//
//  Created by Elad Hayun on 7/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHViewController.h"
#import "EHPathView.h"
#import "EHMountainPath.h"

@interface EHViewController ()

@property (strong, nonatomic) IBOutlet EHPathView *pathView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation EHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.pathView addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", EHMAP_STARTING_SCORE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    
    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y < 750)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:EHTIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:true];
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", EHMAP_STARTING_SCORE];
    }
    else if (panRecognizer.state == UIGestureRecognizerStateChanged)
    {
        for (UIBezierPath *path in [EHMountainPath mountainPathsForRect:self.pathView.bounds])
        {
            UIBezierPath *tapTarget = [EHMountainPath tapTargetForPath:path];
            
            if ([tapTarget containsPoint:fingerLocation])
            {
                [self decrementScoreByAmout:EHWALL_PENALTY];
            }
        }
    }
    else if (panRecognizer.state == UIGestureRecognizerStateEnded && fingerLocation.y <= 65)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Make sure to start at the bottom of the path, hold your finger down and finish at the top!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
}

- (void)timerFired
{
    [self decrementScoreByAmout:EHMAP_SCORE_DECREMENT_AMOUNT];
}

- (void)decrementScoreByAmout:(int)amount
{
    NSString *scoreText = [[self.scoreLabel.text componentsSeparatedByString:@" "] lastObject];
    int score = [scoreText intValue];
    score = score - amount;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
}











@end
