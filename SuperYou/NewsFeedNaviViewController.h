//
//  NewsFeedNaviViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFeedHomeViewController.h"
#import "BaseNaviHomeViewController.h"
@interface NewsFeedNaviViewController : BaseNaviHomeViewController
@property(nonatomic, strong)NewsFeedHomeViewController* newsFeedHomeViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data;
@end
