//
//  NotificationsNaviViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "NotificationsNaviViewController.h"

@interface NotificationsNaviViewController ()

@end

@implementation NotificationsNaviViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.notificationsHomeViewController = [[NotificationsHomeViewController alloc]initWithNibName:@"NotificationsHomeViewController" bundle:nil userdata:data];
        [self addChildViewController:self.notificationsHomeViewController];
    }
    return self;
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
