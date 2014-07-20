//
//  NotificationsNaviViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationsHomeViewController.h"
#import "BaseNaviSecondaryViewController.h"
@interface NotificationsNaviViewController : BaseNaviSecondaryViewController
@property(nonatomic, strong)NotificationsHomeViewController* notificationsHomeViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data;
@end
