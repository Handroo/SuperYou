//
//  MissionsHomeViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "BasePrimaryViewController.h"
#import "UserData.h"
@interface MissionsHomeViewController : BasePrimaryViewController
@property (strong, nonatomic) IBOutlet UITableView *missionsTableView;
@property (nonatomic, strong) UserData* userData;
@property (nonatomic, retain) UIBarButtonItem *menuButton;
@property (nonatomic, strong) NSArray *receivedJSONArray;
@property (nonatomic, strong) NSMutableArray *rowPictures;
@property(nonatomic, strong) NSMutableDictionary *pictureStorage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data;
-(void)didSelectComments;
@end
