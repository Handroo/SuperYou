//
//  MissionsNaviViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MissionsHomeViewController.h"
#import "LocalMissionsViewController.h"
#import "BaseNaviSecondaryViewController.h"
@interface MissionsNaviViewController : BaseNaviSecondaryViewController
@property(nonatomic, strong)MissionsHomeViewController* missionsHomeViewController;
@property(nonatomic, strong)LocalMissionsViewController* localMissionsHomeViewController;
-(void)switchViewControllers:(NSInteger)index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data;
@end
