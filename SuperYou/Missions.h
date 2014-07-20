//
//  Missions.h
//  SuperYou
//
//  Created by Andrew Han on 6/23/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Missions : NSObject

@property(nonatomic, strong) NSString* creatorUserId;
@property(nonatomic, strong) NSString* completeUserId;
@property(nonatomic, strong) NSString* creatorUserName;
@property(nonatomic, strong) NSString* completeUserName;
@property(nonatomic, strong) NSString* completionDate;
@property(nonatomic, strong) NSString* creationDate;

@property(nonatomic, strong) NSString* description;
@property(nonatomic, strong) NSString* friendCount;
@property(nonatomic, strong) NSString* missionId;
@property(nonatomic, strong) NSString* personalMissionCount;

@end
