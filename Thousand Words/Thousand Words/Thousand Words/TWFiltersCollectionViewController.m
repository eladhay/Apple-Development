//
//  TWFiltersCollectionViewController.m
//  Thousand Words
//
//  Created by Elad Hayun on 8/3/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "TWFiltersCollectionViewController.h"
#import "TWPhotoCollectionViewCell.h"
#import "Photo.h"

@interface TWFiltersCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *filters;
@property (strong, nonatomic) CIContext *context;

@end

@implementation TWFiltersCollectionViewController

- (CIContext *) context
{
	if (!_context)
	{
		_context = [CIContext contextWithOptions:nil];
	}
	
	return _context;
}

- (NSMutableArray *) filters
{
	if (!_filters)
	{
		_filters = [NSMutableArray new];
	}
	
	return _filters;
}

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
	
	self.filters = [[[self class] photoFilters] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

+ (NSArray *)photoFilters
{
	CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:nil];
	CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:nil];
	CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents", [CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9], @"inputMinComponents", [CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2], nil];
	CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues:nil];
	CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues:nil];
	CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues:nil];
	CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputSaturationKey, @0.5, nil];
	CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues:nil];
	CIFilter *unsharpen = [CIFilter filterWithName:@"CIUnsharpMask" keysAndValues:nil];
	CIFilter *monochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:nil];
	
	NSArray *allFilters = @[sepia, blur, colorClamp, instant, noir, vignette, colorControls, transfer, unsharpen, monochrome];
	
	return allFilters;
}

- (UIImage *)filteredImageFromImage:(UIImage *)image andFilter:(CIFilter *)filter
{
	CIImage *unfilteredImage = [[CIImage alloc] initWithCGImage:image.CGImage];
	[filter setValue:unfilteredImage forKey:kCIInputImageKey];
	CIImage *filteredImage = [filter outputImage];
	CGRect extent = [filteredImage extent];
	CGImageRef cgImage = [self.context createCGImage:filteredImage fromRect:extent];
	UIImage *finalImage = [UIImage imageWithCGImage:cgImage];
	
	return finalImage;
}

#pragma mark - UICollectionView Data Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Photo Cell";
	TWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
	cell.backgroundColor = [UIColor whiteColor];
	
	dispatch_queue_t filterQueue = dispatch_queue_create("filter queue", NULL);
	
	dispatch_async(filterQueue,
				   ^{
					   //Apply filters on a parallel thread.
					   UIImage *filterImage = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];
					   
					   //Update the UI on the main thread.
					   dispatch_async(dispatch_get_main_queue(),
									  ^{
										  cell.imageView.image = filterImage;
									  });
				   });
	
	return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.filters count];
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	TWPhotoCollectionViewCell *selectedCell = (TWPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
	
	self.photo.image = selectedCell.imageView.image;
	
	if (self.photo.image)
	{
		NSError *error = nil;
		
		if (![self.photo.managedObjectContext save:&error])
		{
			//Handle Error.
		}
		
		[self.navigationController popViewControllerAnimated:true];
	}
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
