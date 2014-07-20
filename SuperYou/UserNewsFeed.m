//
//  UserNewsFeed.m
//  SuperYou
//
//  Created by Andrew Han on 7/6/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "UserNewsFeed.h"
#import "UserData.h"
#import "Missions.h"
#import "Friendship.h"
@interface UserNewsFeed()
{
    NSMutableData *_downloadedData;
    UserData* _rootData;
}
@end
@implementation UserNewsFeed

-(void)assignId:(NSString*)user_id source:(id)source{
    _rootData = source;
//    self.friendsArray = [[NSMutableArray alloc]init];
    self.user_id = user_id;
    self.feedArray =[[NSMutableArray alloc]init];
    [self askServerForUserNotifications];
}

-(void)askServerForUserNotifications{
    NSString *post = [NSString stringWithFormat:@"user_id=%@",self.user_id];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    //    NSString *postLength = [NSString stringWithFormat:@"%d", [post length]];
    NSURL *url = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/getUserNewsFeed.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request addValue:[NSString stringWithFormat:@"%d",postData.length] forHTTPHeaderField:@"Content-Length"];
    //initialize an NSURLConnection  with the request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
    else{
        NSLog(@"Connection Success");
    }
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    
    //Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        if([jsonElement[@"type"] isEqualToString:@"friendship"]){
            Friendship* f = [[Friendship alloc]init];
            f.acceptUserId = jsonElement[@"accept_user_id"];
            f.acceptUserName = jsonElement[@"accept_name"];
            f.requestUserId = jsonElement[@"request_user_id"];
            f.requestUserName = jsonElement[@"request_name"];
            
            [self.feedArray addObject:f];
            
        }else if([jsonElement[@"type"] isEqualToString:@"mission"]){
            Missions* m = [[Missions alloc]init];
            if([self.user_id isEqualToString:jsonElement[@"creator_user_id"]]){
                    m.completeUserName = jsonElement[@"name"];
                    m.creatorUserName = _rootData.name;
            }else{
                m.completeUserName = _rootData.name;
                m.creatorUserName = jsonElement[@"name"];
            }
            m.completeUserId = jsonElement[@"complete_user_id"];
            m.creatorUserId = jsonElement[@"creator_user_id"];
          
            m.completionDate = jsonElement[@"completion_date"];
            m.creationDate = jsonElement[@"creation_date"];
            m.description = jsonElement[@"description"];
            m.friendCount = jsonElement[@"friend_count"];
            m.missionId = jsonElement[@"mission_id"];
            m.personalMissionCount = jsonElement[@"personal_missions"];
            [self.feedArray addObject:m];
        }
        //
        
    }
    [(UserData*)_rootData finishedLoading];
    
}


@end
