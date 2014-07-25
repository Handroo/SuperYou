//
//  NewsFeedHomeViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "NewsFeedHomeViewController.h"
#import "FriendTableViewCell.h"
#import "MissionTableViewCell.h"
#import "Missions.h"
#import "Friendship.h"
#import "PhotoCache.h"
#import "ViewMissionViewController.h"
@interface NewsFeedHomeViewController ()

@end

@implementation NewsFeedHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userData = data;
        self.newsFeedArray = [[NSMutableArray alloc]init];
         self.navigationItem.title = @"SuperYou";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.newsFeedArray addObjectsFromArray:self.userData.userNewsFeed.feedArray];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 165;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [self.newsFeedTableView cellForRowAtIndexPath:indexPath];
    if([cell isKindOfClass:[MissionTableViewCell class]]){
        ViewMissionViewController *view = [[ViewMissionViewController alloc]initWithMission:[self packageCellToMission:(MissionTableViewCell*)cell]];
        [self.navigationController pushViewController:view animated:YES];
        
    }
}

-(Missions*)packageCellToMission:(MissionTableViewCell*)cell{
    Missions* temp = [[Missions alloc]init];
    temp.creatorUserId = cell.creatorUserId;
    temp.creatorUserName = cell.creatorName.text;
    temp.completeUserName = cell.finisherName.text;
    //        temp.completeUserId = cell.;
    temp.completionDate = cell.timeCompleted.text;
    temp.creationDate = cell.timeCreated.text;
    temp.description = cell.missionDescription.text;
    temp.missionId = cell.missionId;
    
    return temp;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.newsFeedArray count];  //count number of row from counting array hear cataGorry is An Array
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell == nil)
    {
        if([self.newsFeedArray[indexPath.row] isKindOfClass:[Missions class]]){
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MissionTableViewCell" owner:self options:nil];
            cell = (MissionTableViewCell*)[topLevelObjects objectAtIndex:0];
            ((MissionTableViewCell*)cell).missionId =[self.newsFeedArray[indexPath.row] missionId];
            ((MissionTableViewCell*)cell).timeCreated.text =[self.newsFeedArray[indexPath.row] creationDate];
            ((MissionTableViewCell*)cell).creatorName.text =[self.newsFeedArray[indexPath.row] creatorUserName];
            ((MissionTableViewCell*)cell).creatorUserId =[self.newsFeedArray[indexPath.row] creatorUserId];
            ((MissionTableViewCell*)cell).finisherName.text =[self.newsFeedArray[indexPath.row] completeUserName];
            if([[PhotoCache photoDictionary] objectForKey:[self.newsFeedArray[indexPath.row] creatorUserId]]){
                ((MissionTableViewCell*)cell).creatorPic.image =[[PhotoCache photoDictionary] objectForKey:[self.newsFeedArray[indexPath.row] creatorUserId]];
                
            }
            else{
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Success! Include your code to handle the results here
                        ((MissionTableViewCell*)cell).creatorPic.image = [[UIImage alloc] initWithData:
                                                                          [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", [self.newsFeedArray[indexPath.row] creatorUserId]]]]
                                                                          ];
                        //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                        [[PhotoCache photoDictionary] setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:[self.newsFeedArray[indexPath.row] creatorUserId]];
                        NSLog(@"loading a new picture");
                    } else {
                        // An error occurred, we need to handle the error
                        // See: https://developers.facebook.com/docs/ios/errors
                    }
                }];
            }

            
            if([[self.newsFeedArray[indexPath.row] completeUserId] isEqual:@"0"]){
                ((MissionTableViewCell*)cell).missionDescription.text =[self.newsFeedArray[indexPath.row] description];
                [((MissionTableViewCell*)cell).missionDescription setEditable:NO];
                ((MissionTableViewCell*)cell).finisherName.hidden = YES;
                ((MissionTableViewCell*)cell).finisherPic.hidden = YES;
                ((MissionTableViewCell*)cell).completedByLabelStatic.hidden = YES;
                ((MissionTableViewCell*)cell).timeCompleted.hidden = YES;
            }
            else{
                [((MissionTableViewCell*)cell) setBackgroundColor:[UIColor yellowColor]];
                ((MissionTableViewCell*)cell).missionDescription.hidden = YES;
                ((MissionTableViewCell*)cell).timeCreated.hidden = YES;
                
                if([[PhotoCache photoDictionary] objectForKey:[self.newsFeedArray[indexPath.row] completeUserId]]){
                    ((MissionTableViewCell*)cell).finisherPic.image =[[PhotoCache photoDictionary] objectForKey:[self.newsFeedArray[indexPath.row] completeUserId]];
                    
                }
                else{
                    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                        if (!error) {
                            // Success! Include your code to handle the results here
                            ((MissionTableViewCell*)cell).finisherPic.image = [[UIImage alloc] initWithData:
                                                                               [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", [self.newsFeedArray[indexPath.row] completeUserId]]]]
                                                                               ];
                            //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                            [[PhotoCache photoDictionary] setObject:((MissionTableViewCell*)cell).finisherPic.image forKey:[self.newsFeedArray[indexPath.row] completeUserId]];
                            NSLog(@"loading a new picture");
                        } else {
                            // An error occurred, we need to handle the error
                            // See: https://developers.facebook.com/docs/ios/errors
                        }
                    }];
                }

            }
            
            [((MissionTableViewCell*)cell) setUserHistory];
        }else if([self.newsFeedArray[indexPath.row] isKindOfClass:[Friendship class]]){
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FriendTableViewCell" owner:self options:nil];
            cell = (FriendTableViewCell*)[topLevelObjects objectAtIndex:0];
            
            if([[self.newsFeedArray[indexPath.row] acceptUserId]isEqualToString:@"0"]){
                [((FriendTableViewCell*)cell) wasNotDecided];
            }else{
                ((FriendTableViewCell*)cell).receiverName.text = [self.newsFeedArray[indexPath.row] acceptUserName] ;
                [((FriendTableViewCell*)cell) wasDecided];
            }
            ((FriendTableViewCell*)cell).requestorName.text = [self.newsFeedArray[indexPath.row] requestUserName];
            
            if([[PhotoCache photoDictionary] objectForKey:[self.newsFeedArray[indexPath.row] acceptUserId]]){
                ((FriendTableViewCell*)cell).receiverPicture.image =[[PhotoCache photoDictionary] objectForKey:[self.newsFeedArray[indexPath.row] acceptUserId]];
                
            }
            else{
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Success! Include your code to handle the results here
                        ((FriendTableViewCell*)cell).receiverPicture.image = [[UIImage alloc] initWithData:
                                                                              [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", [self.newsFeedArray[indexPath.row] acceptUserId]]]]
                                                                              ];
                        //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                        [[PhotoCache photoDictionary] setObject:((FriendTableViewCell*)cell).receiverPicture.image forKey:[self.newsFeedArray[indexPath.row] acceptUserId]];
                        NSLog(@"loading a new picture");
                    } else {
                        // An error occurred, we need to handle the error
                        // See: https://developers.facebook.com/docs/ios/errors
                    }
                }];
            }
            
            if([[PhotoCache photoDictionary] objectForKey:[self.newsFeedArray[indexPath.row] requestUserId]]){
                ((FriendTableViewCell*)cell).requestorPicture.image =[[PhotoCache photoDictionary] objectForKey:[self.newsFeedArray[indexPath.row] requestUserId]];
                
            }
            else{
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Success! Include your code to handle the results here
                        ((FriendTableViewCell*)cell).requestorPicture.image = [[UIImage alloc] initWithData:
                                                                               [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", [self.newsFeedArray[indexPath.row] requestUserId]]]]
                                                                               ];
                        //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                        [[PhotoCache photoDictionary] setObject:((FriendTableViewCell*)cell).requestorPicture.image forKey:[self.newsFeedArray[indexPath.row] requestUserId]];
                        NSLog(@"loading a new picture");
                    } else {
                        // An error occurred, we need to handle the error
                        // See: https://developers.facebook.com/docs/ios/errors
                    }
                }];
            }

        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AnIdentifierString"];
            cell.textLabel.text = @"News";
        }
    }
    return cell;
}




@end
