//
//  EHMatchesViewController.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHMatchesViewController.h"
#import "EHChatViewController.h"

@interface EHMatchesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *availableChatRooms;

@end

@implementation EHMatchesViewController

#pragma mark - Lazy instantiation

- (NSMutableArray *)availableChatRooms
{
	if (!_availableChatRooms)
	{
		_availableChatRooms = [[NSMutableArray alloc] init];
	}
	
	return _availableChatRooms;
}

#pragma mark - View Configuration

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
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self updateAvailableChatRooms];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	EHChatViewController *chatVC = segue.destinationViewController;
	NSIndexPath *indexPath = sender;
	chatVC.chatRoom = [self.availableChatRooms objectAtIndex:indexPath.row];
}

#pragma mark - Helper Methods

- (void)updateAvailableChatRooms
{
	PFQuery *query = [PFQuery queryWithClassName:kEHChatRoomClassKey];
	[query whereKey:kEHChatRoomUser1Key equalTo:[PFUser currentUser]];

	PFQuery *queryInverse = [PFQuery queryWithClassName:kEHChatRoomClassKey];
	[query whereKey:kEHChatRoomUser2Key equalTo:[PFUser currentUser]];
	
	PFQuery *combinedQuery = [PFQuery orQueryWithSubqueries:@[query, queryInverse]];
	[combinedQuery includeKey:kEHChatClassKey];
	[combinedQuery includeKey:kEHChatRoomUser1Key];
	[combinedQuery includeKey:kEHChatRoomUser2Key];
	[combinedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (!error)
		{
			[self.availableChatRooms removeAllObjects];
			self.availableChatRooms = [objects mutableCopy];
			[self.tableView reloadData];
			
		}
	}];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.availableChatRooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	PFObject *chatRoom = [self.availableChatRooms objectAtIndex:indexPath.row];
	
	PFUser *likedUser;
	PFUser *currentUser = [PFUser currentUser];
	PFUser *testUser = chatRoom[kEHChatRoomUser1Key];
	if ([testUser.objectId isEqual:currentUser.objectId])
	{
		likedUser = [chatRoom objectForKey:kEHChatRoomUser2Key];
	}
	else
	{
		likedUser = [chatRoom objectForKey:kEHChatRoomUser1Key];
	}
	
	cell.textLabel.text = likedUser[kEHUserProfileKey][kEHUserProfileFirstNameKey];
	
	// cell.imageView.image = place holder image.
	cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
	
	PFQuery *queryForPhoto = [[PFQuery alloc] initWithClassName:kEHPhotoClassKey];
	[queryForPhoto whereKey:kEHPhotoUserKey equalTo:likedUser];
	[queryForPhoto findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if ([objects count] > 0)
		{
			PFObject *photo = objects[0];
			PFFile *pictureFile = photo[kEHPhotoPictureKey];
			[pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
			{
				cell.imageView.image = [UIImage imageWithData:data];
				cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
			}];
		}
	}];
	
	return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self performSegueWithIdentifier:@"matchesToChatSegue" sender:indexPath];
}

@end
