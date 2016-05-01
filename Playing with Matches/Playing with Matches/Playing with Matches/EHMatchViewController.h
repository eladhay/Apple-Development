//
//  EHMatchViewController.h
//  Playing with Matches
//
//  Created by Elad Hayun on 8/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EHMatchViewControllerDelegate <NSObject>

- (void)presentMatchesViewController;

@end

@interface EHMatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;
@property (weak) id <EHMatchViewControllerDelegate> delegate;

@end
