//
//  UserData.m
//  SuperYou
//
//  Created by Andrew Han on 6/18/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "UserData.h"
#import "AppDelegate.h"
#import "MissionTableViewCell.h"
#import "PhotoCache.h"
@interface UserData()
{
    NSMutableData *_downloadedData;
    id _sourceCaller;
    int _callBackCount;
}
@end

@implementation UserData


-(void)assignId:(NSString*)userID name:(NSString*)name source:(id)source{
    
    //frim this it cshould call the user missions and user complleted missions
    _sourceCaller = source;
    self.user_id = userID;
    self.name = name;
    _callBackCount = 0;
    
    [self downloadProfileItems];
    
    self.userMissions = [[UserMissions alloc]init];
    [self.userMissions assignId:self.user_id source:self];
    
    self.userCompletedMissions = [[UserCompletedMissions alloc]init];
    [self.userCompletedMissions assignId:self.user_id source:self];
    
    self.userFriends = [[UserFriends alloc]init];
    [self.userFriends assignId:self.user_id source:self];
    
    self.userNotifications = [[UserNotifications alloc]init];
    [self.userNotifications assignId:self.user_id source:self];
    
    self.userNewsFeed = [[UserNewsFeed alloc]init];
    [self.userNewsFeed assignId:self.user_id source:self];
    
    self.userLikes = [[UserLikes alloc]init];
    [self.userLikes assignId:self.user_id source:self];
    
    if(self.profile_picture == nil && ![[PhotoCache photoDictionary]objectForKey:self.user_id]){
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                self.profile_picture = [[UIImage alloc] initWithData:
                                            [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", self.user_id]]]
                                            ];
                
                NSLog(@"Facebook got the profile picture");
                
            } else {
                // An error occurred, we need to handle the error
                // See: https://developers.facebook.com/docs/ios/errors
            }
        }];
        [[PhotoCache photoDictionary] setObject:self.profile_picture forKey:self.user_id];
    }else{
        self.profile_picture = [[PhotoCache photoDictionary] objectForKey:self.user_id];
    }
    
//    self.profile_picture = self.tempprofile_picture;
    
    
    
}


-(void)downloadProfileItems
{
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&name=%@",self.user_id, self.name];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/service.php"];
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:jsonFileUrl];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request addValue:[NSString stringWithFormat:@"%d",postData.length] forHTTPHeaderField:@"Content-Length"];
//    NSLog(@"%@", post);
    // Create the NSURLConnection
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
//    NSMutableArray *_user = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    
    //Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        self.name = jsonElement[@"name"];
        self.user_id = jsonElement[@"user_id"];
        self.missions_complete = jsonElement[@"missions_complete"];
        self.personal_missions = jsonElement[@"personal_missions"];
        self.friend_count = jsonElement[@"friend_count"];

    }
    NSLog(@"finish downloading user data initially");
    _callBackCount++;
    
}

-(void)finishedLoading{
    
    _callBackCount++;
    //Five elements in total
    if(_callBackCount>6){
        _callBackCount = 0;
        if([_sourceCaller isMemberOfClass:[MissionTableViewCell class]]) {
            
            [(MissionTableViewCell*)_sourceCaller continueAfterUserDataLoaded];
        }
        else if([_sourceCaller isMemberOfClass:[ProfileHomeViewController class]]) {
            
            [(ProfileHomeViewController*)_sourceCaller continueAfterUserDataLoaded];
        }
        else if([_sourceCaller isMemberOfClass:[AppDelegate class]]) {
            
            [(AppDelegate*)_sourceCaller continueAfterUserDataLoaded];
        }
        
    }
}

-(void)userMissionsFinishLoading{
    self.userCompletedMissions = [[UserCompletedMissions alloc]init];
    [self.userCompletedMissions assignId:self.user_id source:self];
}

-(void)userCompletedMissionsFinishLoading{
    
    
}

-(void)userFriendsFinishLoading{
    
    
}

@end
