//
//  LocalMissionsViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "LocalMissionsViewController.h"
#import "MissionsNaviViewController.h"
#define METERS_PER_MILE 1609.344
@interface LocalMissionsViewController ()

@end

@implementation LocalMissionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Missions";
        [self setListBarButton];
        [self populateMap];
    }
    return self;
}

-(void)setListBarButton{
    self.menuButton = [[UIBarButtonItem alloc]
                       initWithTitle:@"List"
                       style:UIBarButtonItemStyleBordered
                       target:self
                       action:@selector(switchToList)];
    //    self.naviController.navigationItem.leftBarButtonItem = flipButton;
    self.menuButton.tag=1;
    [self.navigationItem setRightBarButtonItem:self.menuButton animated:NO];
}

-(void)switchToList{
        [(MissionsNaviViewController*)self.navigationController switchViewControllers:1];
}

-(void)populateMap{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];

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
