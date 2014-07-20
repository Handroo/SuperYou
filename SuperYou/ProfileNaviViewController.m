//
//  ProfileNaviViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "ProfileNaviViewController.h"

@interface ProfileNaviViewController ()

@end

@implementation ProfileNaviViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.profileHomeViewController = [[ProfileHomeViewController alloc]initWithNibName:@"ProfileHomeViewController" bundle:nil userdata:data];
//        self.profileHomeViewController.profileActionButton.hidden = YES;
        self.profileHomeViewController.disableFriendRequestButton = YES;
        [self addChildViewController:self.profileHomeViewController];
        
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
