//
//  NewsFeedHomeViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePrimaryViewController.h"
#import "UserData.h"
@interface NewsFeedHomeViewController : BasePrimaryViewController
@property (strong, nonatomic) IBOutlet UILabel *emptyLabel;
@property (weak, nonatomic) IBOutlet UITableView *newsFeedTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData*)data;
@property(nonatomic, strong) UserData *userData;
@property(nonatomic, strong) NSMutableArray *newsFeedArray;
@end
