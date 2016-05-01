//
//  MBFViewController.h
//  Man's Best Friend
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBFViewController : UIViewController

@property (nonatomic) int currentDogIndex;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *breedLabel;
@property (strong, nonatomic) NSMutableArray *myDogs;

-(void)printHelloWorld;
-(IBAction)newDogBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
