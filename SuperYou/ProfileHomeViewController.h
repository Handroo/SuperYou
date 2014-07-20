//
//  ProfileHomeViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "BasePrimaryViewController.h"
#import "UserData.h"



@interface ProfileHomeViewController : BasePrimaryViewController<NSURLConnectionDataDelegate>
@property(nonatomic, retain) UIImage* profilePictureImage;
@property(nonatomic, strong) UserData *userData;
@property(nonatomic) BOOL *disableFriendRequestButton;
@property(nonatomic) BOOL *friendAlready;
@property(nonatomic, weak)IBOutlet UIImageView* profilePicture;

//@property(nonatomic, weak)IBOutlet UILabel* missionsComplete;
//@property(nonatomic, weak)IBOutlet UILabel* yourMissions;
//@property(nonatomic, weak)IBOutlet UILabel* yourFriends;


@property(nonatomic, weak)IBOutlet UIButton* missionsComplete;
@property(nonatomic, weak)IBOutlet UIButton* yourMissions;
@property(nonatomic, weak)IBOutlet UIButton* yourFriends;


@property(nonatomic, weak)IBOutlet UITableView* missionsCompleteTableView;
@property(nonatomic, weak)IBOutlet UITableView* yourMissionsTableView;
@property(nonatomic, weak)IBOutlet UITableView* friendsTableView;

-(IBAction)missionsCompletePressed:(id)sender;
-(IBAction)yourMissionsPressed:(id)sender;
-(IBAction)yourFriendsPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *profileActionButton;
- (IBAction)profileActionButtonPressed:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData*)data;
-(void)continueAfterUserDataLoaded;
@end
