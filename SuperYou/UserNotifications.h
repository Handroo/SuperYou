//
//  UserNotifications.h
//  SuperYou
//
//  Created by Andrew Han on 7/2/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserNotifications : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic, strong)NSString* user_id;
-(void)assignId:(NSString*)user_id source:(id)source;
@property(nonatomic, strong)NSMutableArray* friendsArray;
@property(nonatomic, strong)NSMutableArray* missionArray;
@end
