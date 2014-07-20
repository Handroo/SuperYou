//
//  ViewMissionViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/24/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Missions.h"
@interface ViewMissionViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
@property(nonatomic, strong)Missions* mission;
@property (strong, nonatomic) IBOutlet UIButton *acceptMisionButton;
@property(nonatomic, weak) IBOutlet UIImageView* creatorImage;
@property(nonatomic, weak) IBOutlet UILabel* creatorName;
@property(nonatomic, weak) IBOutlet UIImageView* completorImage;
@property(nonatomic, weak) IBOutlet UILabel* completorName;
@property(nonatomic, weak) IBOutlet UITextView* missionDescription;
@property(nonatomic, weak) IBOutlet UILabel* completedByStaticLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UITextField *commentTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)acceptMissionPressed:(id)sender;
- (IBAction)likeButtonPressed:(id)sender;
@end
