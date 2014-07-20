//
//  BaseNaviSecondaryViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "BaseNaviSecondaryViewController.h"

@interface BaseNaviSecondaryViewController ()

@end

@implementation BaseNaviSecondaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom initialization
        //        [self.navigationBar setBackgroundColor:[UIColor redColor]];
        //        [self.navigationBar setTranslucent:NO];
        [self.navigationBar setBarTintColor:[UIColor blueColor]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//        [self.navigationBar setBounds:CGRectMake(0, 10, 40, 10)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
