//
//  UserData.h
//  SuperYou
//
//  Created by Andrew Han on 6/18/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UserMissions.h"
#import "UserCompletedMissions.h"
#import "UserFriends.h"
#import "UserNotifications.h"
#import "UserNewsFeed.h"
#import "UserLikes.h"
@interface UserData : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) UserMissions* userMissions;
@property (nonatomic, strong) UserLikes* userLikes;
@property (nonatomic, strong) UserCompletedMissions* userCompletedMissions;
@property (nonatomic, strong) UserFriends* userFriends;
@property (nonatomic, strong) UserNotifications* userNotifications;
@property (nonatomic, strong) UserNewsFeed* userNewsFeed;

@property (nonatomic, strong) UIImage *profile_picture;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *missions_complete;
@property (nonatomic, strong) NSString *personal_missions;
@property (nonatomic, strong) NSString *friend_count;
-(void)finishedLoading;
-(void)userFriendsFinishLoading;
-(void)userCompletedMissionsFinishLoading;
-(void)userMissionsFinishLoading;
-(void)assignId:(NSString*)userID name:(NSString*)name source:(id)source;
@end
