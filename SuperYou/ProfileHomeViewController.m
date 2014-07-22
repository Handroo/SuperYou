//
//  ProfileHomeViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "ProfileHomeViewController.h"
#import "AppDelegate.h"
#import "MissionTableViewCell.h"
#import "UserMissions.h"
#import "UserCompletedMissions.h"
#import "Missions.h"
#import "ViewMissionViewController.h"
#import "PhotoCache.h"
@interface ProfileHomeViewController()
{
    NSMutableData *_downloadedData;
    UserData *_friendData;
}
@end



@implementation ProfileHomeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData*)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.disableFriendRequestButton = NO;
        self.friendAlready = NO;
        self.userData = data;
        NSLog(@"Set user data");
        [self setLogoutBarButton];
        
        
    }
    
    
    return self;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.disableFriendRequestButton){
        self.profileActionButton.hidden = YES;
    }
    if(self.friendAlready){
        self.profileActionButton.enabled = NO;
        [self.profileActionButton setTitle:@"Friends" forState:UIControlStateNormal] ;
    }
    // Do any additional setup after loading the view from its nib.
    [self.missionsCompleteTableView setHidden:NO];
    [self.yourMissionsTableView setHidden:YES];
    [self.friendsTableView setHidden:YES];
    
    self.navigationItem.title = self.userData.name;
    
    [self.missionsComplete setTitle:[NSString stringWithFormat:@"%lu Completions", (unsigned long)[self.userData.userCompletedMissions.missionCompletedArray count]] forState:UIControlStateNormal];
//    [self.yourMissions setTitle:[NSString stringWithFormat:@"%lu Wishes", (unsigned long)[self.userData.userMissions.missionArray count]] forState:UIControlStateNormal];
    [self.yourFriends setTitle:[NSString stringWithFormat:@"%lu Friends", (unsigned long)[self.userData.userFriends.friendsDictionary count]] forState:UIControlStateNormal];
    [self.yourMissions setTitle:[NSString stringWithFormat:@"%@ Wishes", self.userData.personal_missions] forState:UIControlStateNormal];
    if(self.profilePicture.image == nil){
        [self.profilePicture setImage:self.userData.profile_picture];
        NSLog(@"Profile view pic got set");
    }

    
}

//-(void)viewWillAppear:(BOOL)animated{
//    if(self.profilePicture.image == nil){
//        [self.profilePicture setImage: self.userData.profile_picture];
//    }
//}


-(void)setLogoutBarButton{
    self.menuButton = [[UIBarButtonItem alloc]
                       initWithTitle:@"Logout"
                       style:UIBarButtonItemStyleBordered
                       target:self
                       action:@selector(logoutOfAccount)];
    //    self.naviController.navigationItem.leftBarButtonItem = flipButton;
    self.menuButton.tag=1;
    [self.navigationItem setRightBarButtonItem:self.menuButton animated:NO];
}

-(void)logoutOfAccount{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
    [appDelegate logOutUser];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)missionsCompletePressed:(id)sender{
    [self.missionsCompleteTableView setHidden:NO];
    [self.yourMissionsTableView setHidden:YES];
    [self.friendsTableView setHidden:YES];
}
-(IBAction)yourMissionsPressed:(id)sender{
    [self.missionsCompleteTableView setHidden:YES];
    [self.yourMissionsTableView setHidden:NO];
    [self.friendsTableView setHidden:YES];
}
-(IBAction)yourFriendsPressed:(id)sender{
    [self.missionsCompleteTableView setHidden:YES];
    [self.yourMissionsTableView setHidden:YES];
    [self.friendsTableView setHidden:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int heightOfCell;
    if([tableView isEqual:self.friendsTableView]){
        heightOfCell = 40;
    }else{
        heightOfCell = 165;
    }
    return heightOfCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rows =1;
    
    if([tableView isEqual:self.missionsCompleteTableView]){
        rows = [self.userData.userCompletedMissions.missionCompletedArray count];
    }else if([tableView isEqual:self.yourMissionsTableView]){
        rows = [self.userData.userMissions.missionArray count];
    }else if([tableView isEqual:self.friendsTableView]){
        rows = [self.userData.userFriends.friendsDictionary count];
    }
    
    return rows;    //count number of row from counting array hear cataGorry is An Array
}

-(void)friendTapped:(NSString*)friendID{
    _friendData = [[UserData alloc]init];
//    friendData.profile_picture = self.creatorPic.image;
    [_friendData assignId:friendID name:[self.userData.userFriends.friendsDictionary objectForKey:friendID] source:self];
    
    
    
}

-(void)continueAfterUserDataLoaded{
    ProfileHomeViewController* profileView = [[ProfileHomeViewController alloc]initWithNibName:@"ProfileHomeViewController" bundle:nil userdata:_friendData];
    
    //    FriendProfileViewController *view = [[FriendProfileViewController alloc]initWithNibName:@"FriendProfileViewController" bundle:nil];
    //    [view getUserData:self.creatorUserId];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([_friendData.user_id isEqual:appDelegate.masterTabBarViewController.userData.user_id] || ![[appDelegate.masterTabBarViewController.userData.userFriends.friendsDictionary objectForKey:_friendData.user_id] isEqual:nil]){
        profileView.disableFriendRequestButton = YES;
    }
    
    [profileView.navigationItem setLeftBarButtonItem:nil];
    [self.navigationController pushViewController:profileView animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if([tableView isEqual:self.yourMissionsTableView]){
        ViewMissionViewController *view = [[ViewMissionViewController alloc]initWithMission:self.userData.userMissions.missionArray[indexPath.row]];
        [self.navigationController pushViewController:view animated:YES];
    }
    else if ([tableView isEqual:self.missionsCompleteTableView]){
        ViewMissionViewController *view = [[ViewMissionViewController alloc]initWithMission:self.userData.userCompletedMissions.missionCompletedArray[indexPath.row]];
        [self.navigationController pushViewController:view animated:YES];
    }
    else if ([tableView isEqual:self.friendsTableView]){
        NSString *userID = [[self.userData.userFriends.friendsDictionary allKeys] objectAtIndex: indexPath.row];
        [self friendTapped:userID];
     }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell == nil)
    {
        if([tableView isEqual:self.yourMissionsTableView]){
            cell = [[MissionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AnIdentifierString"];
            
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MissionTableViewCell" owner:self options:nil];
            cell = (MissionTableViewCell*)[topLevelObjects objectAtIndex:0];
            ((MissionTableViewCell*)cell).timeCreated.text =((Missions*)self.userData.userMissions.missionArray[indexPath.row]).creationDate;
            ((MissionTableViewCell*)cell).creatorName.text =self.userData.name;
           
            [((MissionTableViewCell*)cell).missionDescription setEditable:NO];
            ((MissionTableViewCell*)cell).creatorPic. image=self.userData.profile_picture;
            ((MissionTableViewCell*)cell).creatorUserId =self.userData.user_id;
            ((MissionTableViewCell*)cell).missionId =((Missions*)self.userData.userMissions.missionArray[indexPath.row]).missionId;
       
            if([((Missions*)self.userData.userMissions.missionArray[indexPath.row]).completeUserId isEqual:@"0"]){
    
                 ((MissionTableViewCell*)cell).missionDescription.text =((Missions*)self.userData.userMissions.missionArray[indexPath.row]).description;
                [((MissionTableViewCell*)cell).missionDescription setEditable:NO];
                ((MissionTableViewCell*)cell).finisherName.hidden = YES;
                ((MissionTableViewCell*)cell).finisherPic.hidden = YES;
                ((MissionTableViewCell*)cell).completedByLabelStatic.hidden = YES;
                ((MissionTableViewCell*)cell).timeCompleted.hidden = YES;
            }
            else{
                ((MissionTableViewCell*)cell).missionDescription.hidden = YES;
            }
            [((MissionTableViewCell*)cell) setUserHistory];
        }else if([tableView isEqual:self.missionsCompleteTableView]){
            
            cell = [[MissionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AnIdentifierString"];
            
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MissionTableViewCell" owner:self options:nil];
            cell = (MissionTableViewCell*)[topLevelObjects objectAtIndex:0];
            ((MissionTableViewCell*)cell).creatorUserId = ((Missions*)self.userData.userCompletedMissions.missionCompletedArray[indexPath.row]).creatorUserId;
            ((MissionTableViewCell*)cell).creatorName.text =((Missions*)self.userData.userCompletedMissions.missionCompletedArray[indexPath.row]).creatorUserName;
            ((MissionTableViewCell*)cell).timeCreated.text =((Missions*)self.userData.userCompletedMissions.missionCompletedArray[indexPath.row]).creationDate;
            ((MissionTableViewCell*)cell).missionId =((Missions*)self.userData.userCompletedMissions.missionCompletedArray[indexPath.row]).missionId;
            ((MissionTableViewCell*)cell).finisherName.text =self.userData.name;
            ((MissionTableViewCell*)cell).missionDescription.hidden = YES;
            [((MissionTableViewCell*)cell).missionDescription setEditable:NO];
            ((MissionTableViewCell*)cell).finisherPic. image=self.userData.profile_picture;

            if([[PhotoCache photoDictionary] objectForKey:((MissionTableViewCell*)cell).creatorUserId]){
                ((MissionTableViewCell*)cell).creatorPic.image=[[PhotoCache photoDictionary] objectForKey:((MissionTableViewCell*)cell).creatorUserId];
            }
            else{
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Success! Include your code to handle the results here
                        ((MissionTableViewCell*)cell).creatorPic.image = [[UIImage alloc] initWithData:
                                                                               [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", ((MissionTableViewCell*)cell).creatorUserId]]]
                                                                               ];
                        //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                        [[PhotoCache photoDictionary] setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:((MissionTableViewCell*)cell).creatorUserId];
                        NSLog(@"loading a new picture for creator");
                    } else {
                        NSLog(@"loading a new picture for creator");
                        // An error occurred, we need to handle the error
                        // See: https://developers.facebook.com/docs/ios/errors
                    }
                }];
            }

            
            
            [((MissionTableViewCell*)cell) setBackgroundColor:[UIColor yellowColor]];
            [((MissionTableViewCell*)cell) setUserHistory];
        }else if([tableView isEqual:self.friendsTableView]){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AnIdentifierString"];
            NSString *userID = [[self.userData.userFriends.friendsDictionary allKeys] objectAtIndex: indexPath.row];
            cell.textLabel.text = [self.userData.userFriends.friendsDictionary objectForKey:userID];


        }else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AnIdentifierString"];
        }
    }
    
//    for(UIView * cellSubviews in cell.subviews)
//    {
//        cellSubviews.userInteractionEnabled = NO;
//    }
    
    
    return cell;
}



- (IBAction)profileActionButtonPressed:(id)sender {
    self.profileActionButton.enabled = NO;
    [self.profileActionButton setTitle:@"Sent!" forState:UIControlStateNormal];
    NSLog(@"Pressed");
    [self addFriend];
}

-(void)addFriend
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *post = [NSString stringWithFormat:@"user_id=%@&friend_id=%@",appDelegate.masterTabBarViewController.userData.user_id, self.userData.user_id];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/addFriend.php"];
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:jsonFileUrl];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request addValue:[NSString stringWithFormat:@"%d",postData.length] forHTTPHeaderField:@"Content-Length"];
    // Create the NSURLConnection
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
    else{
        NSLog(@"Connection Success");
    }
}




@end
