//
//  ProfileNaviViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileHomeViewController.h"
#import "BaseNaviSecondaryViewController.h"
@interface ProfileNaviViewController : BaseNaviSecondaryViewController
@property(nonatomic, strong)ProfileHomeViewController* profileHomeViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data;
@end
