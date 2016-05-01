//
//  EHChatViewController.m
//  Playing with Matches
//
//  Created by Elad Hayun on 8/28/14.
//  Copyright (c) 2014 Keydood. All rights reserved.
//

#import "EHChatViewController.h"

@interface EHChatViewController ()

@property (strong, nonatomic) PFUser *withUser;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSTimer *chatsTimer;
@property (strong, nonatomic) NSMutableArray *chats;
@property (nonatomic) BOOL initialLoadComplete;

@end

@implementation EHChatViewController

#pragma mark - Lazy Instantiation

-(NSMutableArray *)chats
{
	if (!_chats)
	{
		_chats = [[NSMutableArray alloc] init];
	}
	
	return _chats;
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
	
	self.delegate = self;
	self.dataSource = self;
	
	[[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
	self.messageInputView.textView.placeHolder = @"New Message";
	[self setBackgroundColor:[UIColor whiteColor]];
	
	self.currentUser = [PFUser currentUser];
	PFUser *testUser = self.chatRoom[kEHChatRoomUser1Key];
	if ([testUser.objectId isEqual:self.currentUser.objectId])
	{
		self.withUser = self.chatRoom[kEHChatRoomUser2Key];
	}
	else
	{
		self.withUser = self.chatRoom[kEHChatRoomUser1Key];
	}
	self.title = self.withUser[kEHUserProfileKey][kEHUserProfileFirstNameKey];
	self.initialLoadComplete = false;
	
	[self checkForNewChats];
	self.chatsTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(checkForNewChats) userInfo:nil repeats:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
	[self.chatsTimer invalidate];
	self.chatsTimer = nil;
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

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.chats count];
}

#pragma mark - UITableView Delegate Required

//- (void)didSendText:(NSString *)text
//{
//	if (text.length != 0)
//	{
//		PFObject *chat = [PFObject objectWithClassName:kEHChatRoomChatKey];
//		[chat setObject:self.chatRoom forKey:kEHChatRoomClassKey];
//		[chat setObject:self.currentUser forKey:kEHActivityFromUserKey];
//		[chat setObject:self.withUser forKey:kEHActivityToUserKey];
//		[chat setObject:text forKey:kEHChatRoomTextKey];
//		[chat saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//		{
//			[self.chats addObject:chat];
//			[JSMessageSoundEffect playMessageSentSound];
//			[self.tableView reloadData];
//			[self finishSend];
//			[self scrollToBottomAnimated:true];
//		}];
//	}
//}

- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date
{
	if (text.length != 0)
	{
		PFObject *chat = [PFObject objectWithClassName:kEHChatClassKey];
		[chat setObject:self.chatRoom forKey:kEHChatChatRoomKey];
		[chat setObject:self.currentUser forKey:kEHChatFromUserKey];
		[chat setObject:self.withUser forKey:kEHChatToUserKey];
		[chat setObject:text forKey:kEHChatTextKey];
		[chat saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
		 {
			 [self.chats addObject:chat];
			 [JSMessageSoundEffect playMessageSentSound];
			 [self.tableView reloadData];
			 [self finishSend];
			 [self scrollToBottomAnimated:true];
		 }];
	}
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
	PFObject *chat = self.chats[indexPath.row];
	PFUser *testFromUser = chat[kEHChatFromUserKey];
	
	if ([testFromUser.objectId isEqual:self.currentUser.objectId])
	{
		return JSBubbleMessageTypeOutgoing;
	}
	else
	{
		return JSBubbleMessageTypeIncoming;
	}
}

- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type forRowAtIndexPath:(NSIndexPath *)indexPath
{
	PFObject *chat = self.chats[indexPath.row];
	PFUser *testFromUser = chat[kEHChatFromUserKey];
	
	if ([testFromUser.objectId isEqual:self.currentUser.objectId])
	{
		return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor js_bubbleGreenColor]];
	}
	else
	{
		return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor js_bubbleLightGrayColor]];
	}
}

- (JSMessageInputViewStyle)inputViewStyle
{
	return JSMessageInputViewStyleFlat;
}

#pragma mark - UITableView Delegate Optional

- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	if ([cell messageType] == JSBubbleMessageTypeOutgoing)
	{
		cell.bubbleView.textView.textColor = [UIColor whiteColor];
	}
}

- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
	return true;
}

#pragma mark - Messages View Data Source Delegate Required

- (id<JSMessageData>)messageForRowAtIndexPath:(NSIndexPath *)indexPath
{
	PFObject *chat = self.chats[indexPath.row];
	NSString *message = chat[kEHChatTextKey];
	return message;
}

- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath sender:(NSString *)sender
{
	return nil;
}

#pragma mark - Helper Methods

- (void)checkForNewChats
{
	int oldChatCount = [self.chats count];
	
	PFQuery *queryForChats = [PFQuery queryWithClassName:kEHChatClassKey];
	[queryForChats whereKey:kEHChatChatRoomKey equalTo:self.chatRoom];
	[queryForChats orderByAscending:kEHChatRoomCreatedAtKey];
	[queryForChats findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (!error)
		{
			if ((self.initialLoadComplete == false) || (oldChatCount != [objects count]))
			{
				self.chats = [objects mutableCopy];
				[self.tableView reloadData];
				
				if (self.initialLoadComplete == true)
				{
					[JSMessageSoundEffect playMessageReceivedSound];
				}
				
				self.initialLoadComplete = true;
				[self scrollToBottomAnimated:true];
			}
		}
	}];
}

@end
