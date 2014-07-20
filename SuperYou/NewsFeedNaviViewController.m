//
//  NewsFeedNaviViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "NewsFeedNaviViewController.h"

@interface NewsFeedNaviViewController ()

@end

@implementation NewsFeedNaviViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.newsFeedHomeViewController = [[NewsFeedHomeViewController alloc]initWithNibName:@"NewsFeedHomeViewController" bundle:nil userdata:data];
        [self addChildViewController:self.newsFeedHomeViewController];
       
        
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
