//
//  FriendRequestTableViewCell.m
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "ProfileHomeViewController.h"
#import "AppDelegate.h"
@implementation FriendTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    // Initialization code
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(requestorTapped)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.requestorName addGestureRecognizer:singleTap];
    [self.requestorName setUserInteractionEnabled:YES];
    [self.requestorName addGestureRecognizer:singleTap];
    [self.requestorName setUserInteractionEnabled:YES];
}

-(void)requestorTapped{

    
    self.requestorData = [[UserData alloc]init];
    self.requestorData.profile_picture = self.requestorPicture.image;
    [self.requestorData assignId:self.requestor_id name:self.requestorName.text source:self];
    //    [self createProfileViewController];
    //    [self performSelector:@selector(createProfileViewController) withObject:nil afterDelay:0.5];
    
    
}

-(void)continueAfterUserDataLoaded{
    [self createRequestorProfileViewController];
}

-(void)createRequestorProfileViewController{
    ProfileHomeViewController* profileView = [[ProfileHomeViewController alloc]initWithNibName:@"ProfileHomeViewController" bundle:nil userdata:self.requestorData];
    
    
    //    FriendProfileViewController *view = [[FriendProfileViewController alloc]initWithNibName:@"FriendProfileViewController" bundle:nil];
    //    [view getUserData:self.creatorUserId];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([self.requestorData.user_id isEqual:appDelegate.masterTabBarViewController.userData.user_id]){
        profileView.disableFriendRequestButton = YES;
    }
    if([appDelegate.masterTabBarViewController.userData.userFriends.friendsDictionary objectForKey:self.requestorData.user_id]){
        profileView.friendAlready = YES;
    }
    [(UINavigationController*)appDelegate.masterTabBarViewController.selectedViewController  pushViewController:profileView animated:YES];
    
    [((UINavigationController*)appDelegate.masterTabBarViewController.selectedViewController).topViewController.navigationItem setLeftBarButtonItem:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)wasDecided{
    [self.acceptButton setHidden:YES];
    [self.denyButton setHidden:YES];
    [self.requestFriendsLabel setHidden:YES];
    
}
-(void)wasNotDecided{
    [self.acceptedFriendsLabel setHidden:YES];
    [self.acceptButton setHidden:NO];
    [self.denyButton setHidden:NO];
}

@end
