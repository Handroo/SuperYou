//
//  MasterSplashViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/11/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface MasterSplashViewController : UIViewController
@property(nonatomic, weak)IBOutlet UIButton *accountLogin;
- (IBAction)fbButtonTouched:(id)sender;
@end
