//
//  TWPhotoDetailViewController.m
//  Thousand Words
//
//  Created by Elad Hayun on 8/3/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "TWPhotoDetailViewController.h"
#import "TWFiltersCollectionViewController.h"
#import "Photo.h"

@interface TWPhotoDetailViewController ()

@end

@implementation TWPhotoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:true];
	
	self.imageView.image = self.photo.image;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Filter Segue"])
	{
		if ([segue.destinationViewController isKindOfClass:[TWFiltersCollectionViewController class]])
		{
			TWFiltersCollectionViewController *targetViewController = segue.destinationViewController;
			targetViewController.photo = self.photo;
		}
	}
}

- (IBAction)addFilterButtonPressed:(UIButton *)sender
{
	
}

- (IBAction)deleteButtonPressed:(UIButton *)sender
{
	[[self.photo managedObjectContext] deleteObject:self.photo];
	
	NSError *error = nil;
    
    if (![[self.photo managedObjectContext] save:&error])
    {
        //We had an error
        NSLog(@"Photo save error %@", error);
    }
	[self.navigationController popViewControllerAnimated:true];
}
@end
