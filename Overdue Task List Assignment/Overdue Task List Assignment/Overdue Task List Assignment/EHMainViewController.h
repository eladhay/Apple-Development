//
//  EHViewController.h
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHTaskObject.h"
#import "EHAddTaskViewController.h"
#import "EHTaskDetailsViewController.h"

@interface EHMainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EHAddTaskObjectViewControllerDelegate, EHTaskDetailsViewControllerDelegate>

// Class Properties
@property (strong, nonatomic) NSMutableArray *tasks;

//IBOutlets
@property (strong, nonatomic) IBOutlet UITableView *tableView;

//Class Methods

//IBActions
- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
