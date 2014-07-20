//
//  LocalMissionsViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BasePrimaryViewController.h"
@interface LocalMissionsViewController : BasePrimaryViewController
@property (nonatomic, retain) UIBarButtonItem *menuButton;
@property(nonatomic, weak)IBOutlet MKMapView *mapView;
@end
