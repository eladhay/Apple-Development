//
//  EHViewController.m
//  UIScrollView Challenge Solution
//
//  Created by Elad Hayun on 7/22/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHViewController.h"

@interface EHViewController ()

@end

@implementation EHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Configure the initial image for the globalImageView property.
    self.globalImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"world-map.jpeg"]];
    
    // Set the frame size of the scroll view to match the frame size of the image view.
    self.scrollView.contentSize = self.globalImageView.frame.size;
    
    // Add the image view as a sub view to the scroll view.
    [self.scrollView addSubview:self.globalImageView];
    
    //Configure the required protocol properties.
    self.scrollView.maximumZoomScale = 2.5;
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    //Return the view to be zoomed - The image view.
    return self.globalImageView;
}

@end
