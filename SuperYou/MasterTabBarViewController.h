//
//  MasterTabBarViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFeedNaviViewController.h"
#import "NotificationsNaviViewController.h"
#import "ProfileNaviViewController.h"
#import "MissionsNaviViewController.h"
#import "UserMissions.h"
#import "UserCompletedMissions.h"
@interface MasterTabBarViewController : UITabBarController
@property(nonatomic, strong)NewsFeedNaviViewController* newsFeedNaviViewController;
@property(nonatomic, strong)NotificationsNaviViewController* notificationsFeedNaviViewController;
@property(nonatomic, strong)MissionsNaviViewController* missionsNaviViewController;
@property(nonatomic, strong)ProfileNaviViewController* profileNaviViewController;
@property(nonatomic, strong)UserData* userData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData*)data;
@end
