//
//  NotificationsHomeViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "BasePrimaryViewController.h"
#import "UserData.h"
@interface NotificationsHomeViewController : BasePrimaryViewController
@property (strong, nonatomic) IBOutlet UILabel *emptyLabel;
@property(nonatomic, weak)IBOutlet UITableView* notificationsTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData*)data;
@property(nonatomic, strong) UserData *userData;
@property(nonatomic, strong) NSMutableArray *notificationArray;
@end
