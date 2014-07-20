//
//  UserCompletedMissions.h
//  SuperYou
//
//  Created by Andrew Han on 6/24/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCompletedMissions : NSObject<NSURLConnectionDataDelegate>


@property(nonatomic, strong)NSString* user_id;
-(void)assignId:(NSString*)user_id source:(id)source;

@property(nonatomic, strong)NSMutableArray* missionCompletedArray;
@end
