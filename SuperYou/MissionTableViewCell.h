//
//  CompletedMissionTableViewCell.h
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
#import "ProfileHomeViewController.h"
@interface MissionTableViewCell : UITableViewCell
@property (nonatomic) NSInteger rowIndex;
@property(nonatomic,weak)UIViewController* superView;
@property(nonatomic, retain) UserData* creatorData;
@property(nonatomic, retain) NSMutableDictionary* likeDictionary;
@property(nonatomic,strong)NSString* missionId;
@property(nonatomic, strong)NSString* creatorUserId;
@property(nonatomic, strong)NSString* finisherUserId;
//@property(nonatomic, retain) ProfileHomeViewController* profileView;
@property(nonatomic, weak)IBOutlet UILabel* timeCreated;
@property(nonatomic, weak)IBOutlet UILabel* timeCompleted;
@property(nonatomic, weak)IBOutlet UILabel* creatorName;
@property(nonatomic, weak)IBOutlet UILabel* finisherName;
@property(nonatomic, weak)IBOutlet UILabel* completedByLabelStatic;
@property(nonatomic, weak)IBOutlet UIImageView* creatorPic;
@property(nonatomic, weak)IBOutlet UIImageView* finisherPic;
@property(nonatomic, weak)IBOutlet UITextView* missionDescription;

@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
- (IBAction)likeButtonPressed:(id)sender;
- (IBAction)commentButtonPressed:(id)sender;
-(void)continueAfterUserDataLoaded;
-(void)setUserHistory;
@end
