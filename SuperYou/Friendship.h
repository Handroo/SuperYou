//
//  Friendship.h
//  SuperYou
//
//  Created by Andrew Han on 7/2/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friendship : NSObject


@property(nonatomic, strong) NSString* acceptUserId;
@property(nonatomic, strong) NSString* requestUserId;
@property(nonatomic, strong) NSString* acceptUserName;
@property(nonatomic, strong) NSString* requestUserName;
@property(nonatomic) BOOL accepted;

@end
