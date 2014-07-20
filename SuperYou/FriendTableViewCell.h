//
//  FriendRequestTableViewCell.h
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
@interface FriendTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *requestorPicture;
@property (strong, nonatomic) IBOutlet UILabel *requestorName;
@property(strong, nonatomic)NSString* requestor_id;
@property(strong, nonatomic)UserData* requestorData;
@property (strong, nonatomic) IBOutlet UIImageView *receiverPicture;
@property (strong, nonatomic) IBOutlet UILabel *receiverName;
@property(strong, nonatomic)NSString* receiver_id;

@property (strong, nonatomic) IBOutlet UILabel *acceptedFriendsLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestFriendsLabel;

@property (strong, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) IBOutlet UIButton *denyButton;

@property (strong, nonatomic) IBOutlet UIButton *acceptButtonPressed;
@property (strong, nonatomic) IBOutlet UIButton *denyButtonPressed;
-(void)wasDecided;
-(void)wasNotDecided;
@end
