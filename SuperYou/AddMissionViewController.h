//
//  AddMissionViewController.h
//  SuperYou
//
//  Created by Andrew Han on 6/19/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMissionViewController : UIViewController<NSURLConnectionDelegate, NSURLConnectionDataDelegate,UITextViewDelegate>
-(IBAction)cancelAddMission:(id)sender;
-(IBAction)postMission:(id)sender;
@property(nonatomic, weak) IBOutlet UITextView* descriptionField;
@property(nonatomic,weak)IBOutlet UIImageView* profilePictureView;
@end
