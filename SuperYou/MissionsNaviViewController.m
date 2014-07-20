//
//  MissionsNaviViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "MissionsNaviViewController.h"
#import "UserData.h"
@interface MissionsNaviViewController ()

@end

@implementation MissionsNaviViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.localMissionsHomeViewController = [[LocalMissionsViewController alloc]initWithNibName:@"LocalMissionsViewController" bundle:nil];
        self.localMissionsHomeViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        [self addChildViewController:self.localMissionsHomeViewController];
        self.missionsHomeViewController = [[MissionsHomeViewController alloc]initWithNibName:@"MissionsHomeViewController" bundle:nil userdata:data];
        self.missionsHomeViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self addChildViewController:self.missionsHomeViewController];
        
        
    }
    return self;
}
-(void)switchViewControllers:(NSInteger)index{
    switch (index) {
        case 1:
            [self setViewControllers:[[NSArray alloc]initWithObjects:self.missionsHomeViewController, nil] animated:NO];
            break;
        case 2:
//            [self pushViewController:self.localMissionsHomeViewController animated:YES];
//            [self presentViewController:self.localMissionsHomeViewController animated:YES completion:nil];
            [self setViewControllers:[[NSArray alloc]initWithObjects:self.localMissionsHomeViewController, nil] animated:NO];
            break;
            
        default:
            break;
    }
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
