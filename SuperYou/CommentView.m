//
//  CommentView.m
//  SuperYou
//
//  Created by Andrew Han on 7/14/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.xibCommentView = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:self options:nil] objectAtIndex:0];
        // now add the view to ourselves...
        [self.xibCommentView setFrame:[self bounds]];
        [self addSubview:self.xibCommentView];
        [self.xibCommentView.commentText setUserInteractionEnabled:NO];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
