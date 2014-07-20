//
//  CompletedMissionTableViewCell.m
//  SuperYou
//
//  Created by Andrew Han on 6/10/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "MissionTableViewCell.h"
#import "AppDelegate.h"
@interface MissionTableViewCell()
{
    NSMutableData *_downloadedData;
}
@end

@implementation MissionTableViewCell

- (void)awakeFromNib
{
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
 self.likeDictionary = appDelegate.masterTabBarViewController.userData.userLikes.missionLikesDictionary;
    // Initialization code
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(creatorTapped)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.creatorName addGestureRecognizer:singleTap];
    [self.creatorName setUserInteractionEnabled:YES];
    [self.creatorPic addGestureRecognizer:singleTap];
    [self.creatorPic setUserInteractionEnabled:YES];
    [self.missionDescription setUserInteractionEnabled:NO];
    [self.likeButton setUserInteractionEnabled:YES];
    [self.commentButton setUserInteractionEnabled:YES];
    
    
}

//Tapping of the left hand side
-(void)creatorTapped{
    
    
    self.creatorData = [[UserData alloc]init];
    self.creatorData.profile_picture = self.creatorPic.image;
    [self.creatorData assignId:self.creatorUserId name:self.creatorName.text source:self];
//    [self createProfileViewController];
//    [self performSelector:@selector(createProfileViewController) withObject:nil afterDelay:0.5];
    
    
}

-(void)setUserHistory{
    
    if([self.likeDictionary objectForKey:self.missionId]){
        [self.likeButton setEnabled:NO];
        [self.likeButton setTitle:@"Liked!" forState:UIControlStateNormal];
    }
}

- (IBAction)likeButtonPressed:(id)sender {
    NSLog(@"liked id: %@",self.missionId);
    [self.likeButton setEnabled:NO];
    [self.likeButton setTitle:@"Liked!" forState:UIControlStateNormal];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(self.missionId != nil){
        NSString *post = [NSString stringWithFormat:@"user_id=%@&mission_id=%@",appDelegate.masterTabBarViewController.userData.user_id, self.missionId];
        NSLog(@"%@",post);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
        // Download the json file
        NSURL *jsonFileUrl = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/userLiked.php"];
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
    NSLog(@"LIKED %@",jsonArray);
    
//    //Loop through Json objects, create question objects and add them to our questions array
//    for (int i = 0; i < jsonArray.count; i++)
//    {
//        NSDictionary *jsonElement = jsonArray[i];
//        self.name = jsonElement[@"name"];
//        self.user_id = jsonElement[@"user_id"];
//        self.missions_complete = jsonElement[@"missions_complete"];
//        self.personal_missions = jsonElement[@"personal_missions"];
//        self.friend_count = jsonElement[@"friend_count"];
//        
//    }
//    NSLog(@"finish downloading user data initially");
//    _callBackCount++;
    
}


- (IBAction)commentButtonPressed:(id)sender {
    NSLog(@"commented");
    //should open the view and automatically open the =keyboard
    

}

-(void)continueAfterUserDataLoaded{
    [self createProfileViewController];
}

-(void)createProfileViewController{
    ProfileHomeViewController* profileView = [[ProfileHomeViewController alloc]initWithNibName:@"ProfileHomeViewController" bundle:nil userdata:self.creatorData];
    
    
    //    FriendProfileViewController *view = [[FriendProfileViewController alloc]initWithNibName:@"FriendProfileViewController" bundle:nil];
    //    [view getUserData:self.creatorUserId];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([self.creatorData.user_id isEqual:appDelegate.masterTabBarViewController.userData.user_id]){
        profileView.disableFriendRequestButton = YES;
    }
    if([appDelegate.masterTabBarViewController.userData.userFriends.friendsDictionary objectForKey:self.creatorData.user_id]){
        profileView.friendAlready = YES;
    }
    [(UINavigationController*)appDelegate.masterTabBarViewController.selectedViewController  pushViewController:profileView animated:YES];
    
    [((UINavigationController*)appDelegate.masterTabBarViewController.selectedViewController).topViewController.navigationItem setLeftBarButtonItem:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
