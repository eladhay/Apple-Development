//
//  EHViewController.m
//  Class Testing Ground
//
//  Created by Elad Hayun on 7/18/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHViewController.h"
#import "MBFDog.h"

@interface EHViewController ()

@end

@implementation EHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *myString = @"The NewFoundLand dog breed has webbed feet which aids in its swimming prowess";
    NSArray *wordsInSentance = [myString componentsSeparatedByString:@" "];
    NSMutableArray *capitalizedWords = [[NSMutableArray alloc] init];
    
//    for (int word = 0; word < [wordsInSentance count]; word++)
//    {
//        NSString *uncapitalizedWord = [wordsInSentance objectAtIndex:word];
//        NSString *capitalizedWord = [uncapitalizedWord capitalizedString];
//        [capitalizedWords addObject:capitalizedWord];
//    }
//    NSLog(@"%@", capitalizedWords);
    
//    for (NSString *word in wordsInSentance) {
//        NSString *capitalizedWord = [word capitalizedString];
//        [capitalizedWords addObject:capitalizedWord];
//    }
//    NSLog(@"%@", capitalizedWords);
    
    MBFDog *dog = [[MBFDog alloc] init];
    [dog setName:@"Sparky"];
    NSLog(@"%@", dog.name);
    NSString *myDogsName = dog.name;
    dog.name = @"Sparky is awesome!";
    NSLog(@"%@", dog.name);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
