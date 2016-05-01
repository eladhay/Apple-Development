//
//  OWOuterSpaceTableViewController.h
//  Out of this World
//
//  Created by Elad Hayun on 7/20/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWAddSpaceObjectViewController.h"

@interface OWOuterSpaceTableViewController : UITableViewController <OWAddSpaceObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;

@end
