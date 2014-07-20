//
//  MasterTabBarViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "MasterTabBarViewController.h"

@interface MasterTabBarViewController ()

@end

@implementation MasterTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData*)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userData = data;
        [self setUpNewsFeedController];
        [self setUpNotificationsController];
        [self setUpProfileController];
        [self setUpMissionsController];
        self.viewControllers = [NSArray arrayWithObjects: self.newsFeedNaviViewController,self.notificationsFeedNaviViewController, self.missionsNaviViewController, self.profileNaviViewController, nil];
    }
//    [self setUpNewsFeedController];
    return self;
}

-(void)setUpNewsFeedController{
    self.newsFeedNaviViewController = [[NewsFeedNaviViewController alloc]initWithNibName:@"NewsFeedNaviViewController" bundle:nil userdata:self.userData];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:1];
    [self.newsFeedNaviViewController  setTabBarItem:item1];
    
}
-(void)setUpMissionsController{
    self.missionsNaviViewController = [[MissionsNaviViewController alloc]initWithNibName:@"MissionsNaviViewController" bundle:nil userdata:self.userData];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"Missions" image:nil tag:1];
    [self.missionsNaviViewController  setTabBarItem:item1];
}

-(void)setUpProfileController{
    
    self.profileNaviViewController = [[ProfileNaviViewController alloc]initWithNibName:@"ProfileNaviViewController" bundle:nil userdata:self.userData];
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"Profile" image:nil tag:1];
    [self.profileNaviViewController  setTabBarItem:item1];
}

-(void)setUpNotificationsController{
    self.notificationsFeedNaviViewController = [[NotificationsNaviViewController alloc]initWithNibName:@"NotificationsNaviViewController" bundle:nil userdata:self.userData];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"Notifications" image:nil tag:1];
    [self.notificationsFeedNaviViewController  setTabBarItem:item1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
