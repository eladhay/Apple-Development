//
//  OWOuterSpaceTableViewController.m
//  Out of this World
//
//  Created by Elad Hayun on 7/20/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "OWOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "OWSpaceObject.h"
#import "OWSpaceImageViewController.h"
#import "OWSpaceDataViewController.h"

@interface OWOuterSpaceTableViewController ()

@end

@implementation OWOuterSpaceTableViewController

#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantiation of Properties

- (NSMutableArray *)planets
{
    if (!_planets)
    {
        _planets = [NSMutableArray new];
    }
    
    return _planets;
}

- (NSMutableArray *)addedSpaceObjects
{
    if (!_addedSpaceObjects)
    {
        _addedSpaceObjects = [NSMutableArray new];
    }
    
    return _addedSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        OWSpaceObject *planet = [[OWSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }
    
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for (NSDictionary *dictionary in myPlanetsAsPropertyLists)
    {
        OWSpaceObject *spaceObject = [self spaceObjectForDictionary:dictionary];
        [self.addedSpaceObjects addObject:spaceObject];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        OWSpaceObject *selectedObject;
        
        if (path.section == 0)
        {
            selectedObject = self.planets[path.row];
        }
        else
        {
            selectedObject = self.addedSpaceObjects[path.row];
        }
        
        if ([segue.destinationViewController isKindOfClass:[OWSpaceImageViewController class]])
        {
            OWSpaceImageViewController *nextViewController = segue.destinationViewController;
            nextViewController.spaceObject = selectedObject;
        }
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]])
    {
        NSIndexPath *path = sender;
        OWSpaceObject *selectedObject;
        
        if (path.section == 0)
        {
            selectedObject = self.planets[path.row];
        }
        else
        {
            selectedObject = self.addedSpaceObjects[path.row];
        }
        
        if ([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]])
        {
            OWSpaceDataViewController *targetViewController = segue.destinationViewController;
            targetViewController.spaceObject = selectedObject;
        }
    }
    
    if ([segue.destinationViewController isKindOfClass:[OWAddSpaceObjectViewController class]]) {
        OWAddSpaceObjectViewController *addSpaceObjectViewController = segue.destinationViewController;
        addSpaceObjectViewController.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([self.addedSpaceObjects count])
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 1)
    {
        return [self.addedSpaceObjects count];
    }
    else
    {
        return [self.planets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (indexPath.section == 1)
    {
        OWSpaceObject *planet = self.addedSpaceObjects[indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    else
    {
        OWSpaceObject *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    
    // Configure the appearence of the TableView cells.
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    return cell;
}

#pragma mark - Helper Methods

- (NSDictionary *) spaceObjectAsPropertyList:(OWSpaceObject *) spaceObject
{
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    
    NSDictionary *dictionary = @{
                                 PLANET_NAME: spaceObject.name,
                                 PLANET_GRAVITY: @(spaceObject.gravitationalForce),
                                 PLANET_DIAMETER: @(spaceObject.diameter),
                                 PLANET_YEAR_LENGTH: @(spaceObject.yearLength),
                                 PLANET_DAY_LENGTH: @(spaceObject.dayLength),
                                 PLANET_TEMPERATURE: @(spaceObject.temperature),
                                 PLANET_NUMBER_OF_MOONS: @(spaceObject.numberOfMoons),
                                 PLANET_NICKNAME: spaceObject.nickname,
                                 PLANET_INTERESTING_FACT: spaceObject.interestingFact,
                                 PLANET_IMAGE: imageData};
    
    return dictionary;
}

- (OWSpaceObject *) spaceObjectForDictionary:(NSDictionary *) dictionary
{
    NSData *dataForImage = dictionary[PLANET_IMAGE];
    UIImage *spaceObjectImage = [UIImage imageWithData:dataForImage];
    
    OWSpaceObject *spaceObject = [[OWSpaceObject alloc] initWithData:dictionary andImage:spaceObjectImage];
    return spaceObject;
}

#pragma mark - OWAddSpaceObjectViewController Delegate

- (void)didCancel
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)addSpaceObject:(OWSpaceObject *)spaceObject
{
    // Add the spaceObject to the addedSpaceObjects array.
    [self.addedSpaceObjects addObject:spaceObject];
    
    // Try reading the saved space object from NSUserDefaults
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    
    // If NSUserDefaults had no space objects saved, make sure to initialize the array as new.
    if (!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [NSMutableArray new];
    
    // Add the spaceObject to the new property list array after converting it to a property list.
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsPropertyList:spaceObject]];
    
    // Save everything to NSUserDefaults and synchronize to persistent storage.
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:true completion:nil];
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) return true;
    else return false;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newSavedSpaceObjectData = [NSMutableArray new];
        for (OWSpaceObject *spaceObject in self.addedSpaceObjects)
        {
            [newSavedSpaceObjectData addObject:[self spaceObjectAsPropertyList:spaceObject]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newSavedSpaceObjectData forKey:ADDED_SPACE_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
