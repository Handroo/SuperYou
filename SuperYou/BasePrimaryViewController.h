//
//  BasePrimaryViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMissionViewController.h"
@interface BasePrimaryViewController : UIViewController
@property (nonatomic, retain) UIBarButtonItem *menuButton;
@property (nonatomic, retain) UIBarButtonItem *addMissionButton;
@property(nonatomic, strong) AddMissionViewController* addMissionViewController;
@end
