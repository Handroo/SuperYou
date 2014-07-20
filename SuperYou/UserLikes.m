//
//  UserLikes.m
//  SuperYou
//
//  Created by Andrew Han on 7/17/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "UserLikes.h"
#import "UserData.h"
@interface UserLikes()
{
    NSMutableData *_downloadedData;
    UserData* _rootData;
}
@end

@implementation UserLikes

-(void)assignId:(NSString*)user_id source:(id)source{
    _rootData = source;
    self.missionLikesDictionary = [[NSMutableDictionary alloc]init];
    self.user_id = user_id;
    [self askServerForUserLikes];
}

-(void)askServerForUserLikes{
    NSString *post = [NSString stringWithFormat:@"user_id=%@",self.user_id];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    //    NSString *postLength = [NSString stringWithFormat:@"%d", [post length]];
    NSURL *url = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/getUserLikes.php"];
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
//     NSLog(@"User LKES: %@",jsonArray );
    
    //Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        if([jsonElement[@"type"] isEqualToString:@"missionlike"]){
            [self.missionLikesDictionary setObject:jsonElement[@"like_time"] forKey:jsonElement[@"mission_id"]];
        }        //
        
    }
    [(UserData*)_rootData finishedLoading];
    
}



@end
