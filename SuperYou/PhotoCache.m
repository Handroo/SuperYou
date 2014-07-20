//
//  PhotoCache.m
//  SuperYou
//
//  Created by Andrew Han on 7/8/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "PhotoCache.h"

@implementation PhotoCache
+(NSMutableDictionary*) photoDictionary
{
    static NSMutableDictionary* photoDict = nil;
    if (photoDict == nil)
    {
        photoDict = [[NSMutableDictionary alloc]init];
    }
    return photoDict;
}
@end
