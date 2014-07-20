//
//  UserNewsFeed.h
//  SuperYou
//
//  Created by Andrew Han on 7/6/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserNewsFeed : NSObject
@property(nonatomic, strong)NSString* user_id;
-(void)assignId:(NSString*)user_id source:(id)source;
//@property(nonatomic, strong)NSMutableArray* friendsArray;
@property(nonatomic, strong)NSMutableArray* feedArray;

@end
