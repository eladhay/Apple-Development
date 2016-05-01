//
//  EHViewController.h
//  Prep For Pirate Assignment
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHAwesomeClass.h"

@interface EHViewController : UIViewController

@property (nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) IBOutlet UIButton *myButton;
@property (strong, nonatomic) EHAwesomeClass *awesomeClass;

@end
