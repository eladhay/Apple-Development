//
//  MBFViewController.m
//  Man's Best Friend
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "MBFViewController.h"
#import "MBFDog.h"
#import "MBFPuppy.h"

@interface MBFViewController ()

@end

@implementation MBFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.currentDogIndex = 0; //Set current index to initial dog.
    
    //Instantiate our dog array.
    self.myDogs = [[NSMutableArray alloc] init];
    
    //Add dogs to our dog array.
    [self.myDogs addObject:[MBFDog createNewDogAged:3 Named:@"Nana" Breed:@"St. Bernard" withImage:[UIImage imageNamed:@"St.Bernard.jpg"]]];
    
    [self.myDogs addObject:[MBFDog createNewDogAged:3 Named:@"Wishbone" Breed:@"Jack Russell Terrier" withImage:[UIImage imageNamed:@"JRT.jpg"]]];
    
    [self.myDogs addObject:[MBFDog createNewDogAged:3 Named:@"Lassie" Breed:@"Border Collie" withImage:[UIImage imageNamed:@"BorderCollie.jpg"]]];
    
    [self.myDogs addObject:[MBFDog createNewDogAged:3 Named:@"Angel" Breed:@"Italian Greyhound" withImage:[UIImage imageNamed:@"ItalianGreyhound.jpg"]]];
    
    [self.myDogs addObject:[MBFPuppy createNewDogAged:1 Named:@"Bo O" Breed:@"Portuguese Water Dog" withImage:[UIImage imageNamed:@"Bo.jpg"]]];
    
    //Set startup view.
    MBFDog *startupDog = [self.myDogs objectAtIndex:self.currentDogIndex];
    self.myImageView.image = startupDog.image;
    self.nameLabel.text = startupDog.name;
    self.breedLabel.text = startupDog.breed;
    
    MBFPuppy *littlePuppy =[[MBFPuppy alloc] init];
    [littlePuppy bark];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)printHelloWorld
{
    NSLog(@"Hello World!");
}

- (IBAction)newDogBarButtonItemPressed:(UIBarButtonItem *)sender
{
    int numberOfDogs = [self.myDogs count];
    int randomIndex = arc4random() % numberOfDogs;
    
    //Make sure we don't get the same dog two times in a row.
    while (self.currentDogIndex == randomIndex) {
        randomIndex = arc4random() % numberOfDogs;
    }
    
    MBFDog *randomDog = [self.myDogs objectAtIndex:randomIndex];
    
    [UIView transitionWithView:self.view duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.myImageView.image = randomDog.image;
        self.breedLabel.text = randomDog.breed;
        self.nameLabel.text = randomDog.name;
    } completion:^(BOOL finished) {
        self.currentDogIndex = randomIndex;
    }];
    sender.title = @"And Another";
}

@end
