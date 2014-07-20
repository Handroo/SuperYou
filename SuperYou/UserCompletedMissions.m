//
//  UserMissions.m
//  SuperYou
//
//  Created by Andrew Han on 6/23/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "UserCompletedMissions.h"
#import "UserData.h"
#import "Missions.h"
@interface UserCompletedMissions()
{
    NSMutableData *_downloadedData;
    UserData* _rootData;
}
@end

@implementation UserCompletedMissions



-(void)assignId:(NSString*)user_id source:(id)source{
    _rootData = source;
        self.missionCompletedArray = [[NSMutableArray alloc]init];
    self.user_id = user_id;
    [self askServerForUserMissions];
}

-(void)askServerForUserMissions{
    NSString *post = [NSString stringWithFormat:@"user_id=%@",self.user_id];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    //    NSString *postLength = [NSString stringWithFormat:@"%d", [post length]];
    NSURL *url = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/getUserCompletedMission.php"];
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
    NSLog(@"User ID: %@",jsonArray );
    
    //Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        Missions* m = [[Missions alloc]init];
        m.creatorUserName = jsonElement[@"creator_name"];
        m.creatorUserId = jsonElement[@"creator_user_id"];
        m.completeUserId = jsonElement[@"complete_user_id"];
        m.completeUserName = jsonElement[@"completor_name"];
        m.completionDate = jsonElement[@"completion_date"];
        m.creationDate = jsonElement[@"creation_date"];
        
        m.description = jsonElement[@"description"];
        m.friendCount = jsonElement[@"friend_count"];
        m.missionId = jsonElement[@"mission_id"];
        m.personalMissionCount = jsonElement[@"personal_missions"];
        
        // Add this question to the user array
        [self.missionCompletedArray addObject:m];
    }
    [(UserData*)_rootData finishedLoading];
}



@end
