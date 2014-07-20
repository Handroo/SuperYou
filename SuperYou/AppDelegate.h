//
//  AppDelegate.h
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterTabBarViewController.h"
#import "MasterSplashViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UserData *data;
@property (nonatomic, strong) MasterTabBarViewController* masterTabBarViewController;
@property (nonatomic, strong) MasterSplashViewController* masterSplashViewController;
-(void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
-(void)logOutUser;
@property (nonatomic, strong) NSCondition *myCondition;
-(void)continueAfterUserDataLoaded;
@end
