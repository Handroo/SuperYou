//
//  BasePrimaryViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "BasePrimaryViewController.h"

@interface BasePrimaryViewController ()

@end

@implementation BasePrimaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                self.addMissionButton = [[UIBarButtonItem alloc]
                           initWithTitle:@"Add"
                           style:UIBarButtonItemStyleBordered
                           target:self
                           action:@selector(popAddMission)];
        //    self.naviController.navigationItem.leftBarButtonItem = flipButton;
        self.addMissionButton.tag=2;
        [self.navigationItem setLeftBarButtonItem:self.addMissionButton animated:NO];
    }
    return self;
}

-(void)popAddMission{
    self.addMissionViewController = [[AddMissionViewController alloc]initWithNibName:@"AddMissionViewController" bundle:nil];

    [self presentViewController:self.addMissionViewController animated:YES completion:nil];
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
