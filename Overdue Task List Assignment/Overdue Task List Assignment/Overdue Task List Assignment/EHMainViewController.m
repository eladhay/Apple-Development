//
//  EHViewController.m
//  Overdue Task List Assignment
//
//  Created by Elad Hayun on 7/26/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHMainViewController.h"
#import "EHTaskDetailsViewController.h"

@interface EHMainViewController ()

@end

@implementation EHMainViewController

#pragma mark - Lazy Instantiation of Properties

// Lazy property instantiation for our tasks array.
- (NSMutableArray *)tasks
{
    if (!_tasks)
    {
        _tasks = [NSMutableArray new];
    }
    
    return _tasks;
}

#pragma mark - View Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *myTasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASKS_ARRAY];
    for (NSDictionary *dictionary in myTasksAsPropertyLists)
    {
        EHTaskObject *taskObject = [EHTaskObject taskObjectForDictionary:dictionary];
        [self.tasks addObject:taskObject];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EHAddTaskObjectViewController Delegate

// The cancel button was clicked on the EHAddTaskObjectViewController
- (void)didCancel
{
    // Dismiss the view without doing anything.
    [self dismissViewControllerAnimated:true completion:nil];
}

// The add button was clicked on the EHAddTaskObjectViewController
- (void)addTaskObject:(EHTaskObject *)taskObject
{
    // Add the task object to the tasks array.
    [self.tasks addObject:taskObject];
    
    // Try reading the saved space object from NSUserDefaults
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASKS_ARRAY] mutableCopy];
    
    // If NSUserDefaults had no task objects saved, make sure to initialize the array as new.
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [NSMutableArray new];
    
    // Add the task object to the new property list array after converting it to a property list.
    [taskObjectsAsPropertyLists addObject:[EHTaskObject taskObjectAsPropertyList:taskObject]];
    
    // Save everything to NSUserDefaults and synchronize to persistent storage.
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASKS_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Dismiss the view and reload the data.
    [self dismissViewControllerAnimated:true completion:nil];
    [self.tableView reloadData];
}

#pragma mark - EHTaskDetailsViewController Delegate

// The add button was clicked on the EHEditTaskObjectViewController
- (void)saveTaskObject
{
    // Refresh the task object view.
    [self saveTasks];
    
    // Dismiss the view.
    [self dismissViewControllerAnimated:true completion:nil];
    
    // Refresh the contents of the table view.
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate and UITableView Delegates Implementation

// Override to support section count handling in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

// Override to rows per section count handling in the table view.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
    {
        return [self.tasks count];
    }
    else
    {
        return 0;
    }
}

// Override to support single cell handling in the table view.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a new TableViewCell and implementi the dequeue logic.
    static NSString *CellIdentifier = @"taskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0)
    {
        // Get the selected task object from the table view.
        EHTaskObject *task = [self.tasks objectAtIndex:indexPath.row];
        
        // Create a formatted date string from the selected task's due date.
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *stringFromDate = [dateFormatter stringFromDate:task.taskDueDate];
        
        // Design the cell text content.
        cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", task.taskTitle, stringFromDate];
        cell.detailTextLabel.text = task.taskDescription;
        
        // Set the background color to match the task over-due state.
        if (task.taskCompleted)
        {
            cell.backgroundColor = [UIColor greenColor];
        }
        else
        {
            BOOL isOverDue = [self isDate:[NSDate date] greaterThan:task.taskDueDate];
            if (isOverDue) cell.backgroundColor = [UIColor redColor];
            else cell.backgroundColor = [UIColor yellowColor];
        }
    }
    
    // Configure the appearence of the TableView cells.
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    return cell;
}

// Override to support the segue to the detailed task view.
- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // When a user clicks the details button, segue to the detailed task view.
    [self performSegueWithIdentifier:@"Push to Task Details" sender:indexPath];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Allow the user to edit the default row.
    if (indexPath.section == 0) return true;
    else return false;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Swipe to Delete from TableView Logic.
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Remove the object from the tasks array.
        [self.tasks removeObjectAtIndex:indexPath.row];
        
        // Create a new array and add the remaining objects.
        NSMutableArray *newSavedTaskObjectData = [NSMutableArray new];
        for (EHTaskObject *taskObject in self.tasks)
        {
            [newSavedTaskObjectData addObject:[EHTaskObject taskObjectAsPropertyList:taskObject]];
        }
        
        // Save the new array as the current data post deletion.
        [[NSUserDefaults standardUserDefaults] setObject:newSavedTaskObjectData forKey:TASKS_ARRAY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

// Override to support selecting a single row on the table view.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the selected task object from the table view.
    EHTaskObject *task = [self.tasks objectAtIndex:indexPath.row];
    
    // Update the selected task with the new completion.
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

// Override to enable moving rows in the table view. Editing mode must be set to false.
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}

// Override to support moving rows in the table view.
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // Reorder the tasks according to the user's selection.
    EHTaskObject *taskObject = self.tasks[sourceIndexPath.row];
    [self.tasks removeObjectAtIndex:sourceIndexPath.row];
    [self.tasks insertObject:taskObject atIndex:destinationIndexPath.row];
    
    // Save the data into persistent storage.
    [self saveTasks];
}

#pragma mark - Helper Methods

// Compare date values for over-due tasks.
- (BOOL)isDate:(NSDate *)firstDate greaterThan:(NSDate *)secondDate
{
    // Create TimerIntervals for date comparison.
    NSTimeInterval firstDateInterval = [firstDate timeIntervalSince1970];
    NSTimeInterval secondDateInterval = [secondDate timeIntervalSince1970];
    
    return (firstDateInterval > secondDateInterval);
}

- (void)updateCompletionOfTask:(EHTaskObject *)task forIndexPath:(NSIndexPath *)indexPath
{
    // Try reading the saved space object from NSUserDefaults
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASKS_ARRAY] mutableCopy];
    
    // If NSUserDefaults had no task objects saved, make sure to initialize the array as new.
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [NSMutableArray new];
    
    // Remove the selected object from the array.
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    // Toggle the task completed status.
    if (task.taskCompleted) task.taskCompleted = false;
    else task.taskCompleted = true;
    
    // Insert the updated object to the same location in the array.
    [taskObjectsAsPropertyLists insertObject:[EHTaskObject taskObjectAsPropertyList:task] atIndex:indexPath.row];
    
    // Save everything to NSUserDefaults and synchronize to persistent storage.
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASKS_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Reload the data in the TableView.
    [self.tableView reloadData];
}

// Save tasks to the persistent storage.
- (void)saveTasks
{
    // Iterate through all our task objects, convert them to property lists and add them to an array.
    NSMutableArray *taskObjectsAsPropertyLists = [NSMutableArray new];
    for (int i = 0; i < [self.tasks count]; i++)
    {
        [taskObjectsAsPropertyLists addObject:[EHTaskObject taskObjectAsPropertyList:self.tasks[i]]];
    }
    
    // Save everything to NSUserDefaults and synchronize to persistent storage.
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASKS_ARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue to the Add Task View.
    if ([segue.destinationViewController isKindOfClass:[EHAddTaskViewController class]]) {
        EHAddTaskViewController *targetViewController = segue.destinationViewController;
        targetViewController.delegate = self;
    }
    
    // Segue to the Task Details View
    if ([segue.destinationViewController isKindOfClass:[EHTaskDetailsViewController class]])
    {
        NSIndexPath *path = sender;
        EHTaskObject *selectedObject;
        selectedObject = self.tasks[path.row];        
        EHTaskDetailsViewController *targetViewController = segue.destinationViewController;
        targetViewController.delegate = self;
        targetViewController.taskObject = selectedObject;
    }
}

#pragma mark - UIButtons

// The organize button on the navigation bar was pressed.
- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender
{
    // Toggle editing mode on the table view.
    if (self.tableView.editing == true) [self.tableView setEditing:false animated:true];
    else [self.tableView setEditing:true animated:true];
}

@end
