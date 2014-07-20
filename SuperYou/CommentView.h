//
//  CommentView.h
//  SuperYou
//
//  Created by Andrew Han on 7/14/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView

@property(nonatomic,weak)IBOutlet UILabel* nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *commentorPic;
@property (strong, nonatomic) IBOutlet UITextView *commentText;
@property(strong,nonatomic) CommentView* xibCommentView;
@end
