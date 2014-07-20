//
//  NotificationsHomeViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "NotificationsHomeViewController.h"
#import "FriendTableViewCell.h"
#import "MissionTableViewCell.h"
#import "Missions.h"
#import "Friendship.h"
#import "PhotoCache.h"
@interface NotificationsHomeViewController ()

@end

@implementation NotificationsHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData*)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userData = data;
        self.notificationArray = [[NSMutableArray alloc]init];
        self.navigationItem.title = @"Notifications";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.notificationArray addObjectsFromArray:self.userData.userNotifications.missionArray];
    [self.notificationArray addObjectsFromArray:self.userData.userNotifications.friendsArray];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.notificationArray count];    //count number of row from counting array hear cataGorry is An Array
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell == nil)
    {
        if([self.notificationArray[indexPath.row] isKindOfClass:[Missions class]]){
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MissionTableViewCell" owner:self options:nil];
            cell = (MissionTableViewCell*)[topLevelObjects objectAtIndex:0];
            
            ((MissionTableViewCell*)cell).missionId =[self.notificationArray[indexPath.row] missionId];
            ((MissionTableViewCell*)cell).timeCreated.text =[self.notificationArray[indexPath.row] creationDate];
            ((MissionTableViewCell*)cell).creatorName.text =[self.notificationArray[indexPath.row] creatorUserName];
            ((MissionTableViewCell*)cell).creatorUserId =[self.notificationArray[indexPath.row] creatorUserId];
                        ((MissionTableViewCell*)cell).finisherName.text =[self.notificationArray[indexPath.row] completeUserName];
            if([[PhotoCache photoDictionary] objectForKey:[self.notificationArray[indexPath.row] creatorUserId]]){
                ((MissionTableViewCell*)cell).creatorPic.image =[[PhotoCache photoDictionary] objectForKey:[self.notificationArray[indexPath.row] creatorUserId]];
                
            }
            else{
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Success! Include your code to handle the results here
                        ((MissionTableViewCell*)cell).creatorPic.image = [[UIImage alloc] initWithData:
                                 [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", [self.notificationArray[indexPath.row] creatorUserId]]]]
                                 ];
                        //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                        [[PhotoCache photoDictionary] setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:[self.notificationArray[indexPath.row] creatorUserId]];
                        NSLog(@"loading a new picture");
                    } else {
                        // An error occurred, we need to handle the error
                        // See: https://developers.facebook.com/docs/ios/errors
                    }
                }];
            }
            
            if([[PhotoCache photoDictionary] objectForKey:[self.notificationArray[indexPath.row] completeUserId]]){
                ((MissionTableViewCell*)cell).finisherPic.image =[[PhotoCache photoDictionary] objectForKey:[self.notificationArray[indexPath.row] completeUserId]];
                
            }
            else{
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Success! Include your code to handle the results here
                        ((MissionTableViewCell*)cell).finisherPic.image = [[UIImage alloc] initWithData:
                                                                          [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", [self.notificationArray[indexPath.row] completeUserId]]]]
                                                                          ];
                        //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                        [[PhotoCache photoDictionary] setObject:((MissionTableViewCell*)cell).finisherPic.image forKey:[self.notificationArray[indexPath.row] completeUserId]];
                        NSLog(@"loading a new picture");
                    } else {
                        // An error occurred, we need to handle the error
                        // See: https://developers.facebook.com/docs/ios/errors
                    }
                }];
            }

            if([[self.notificationArray[indexPath.row] completeUserId] isEqual:@"0"]){
                NSLog(@"yes");
                ((MissionTableViewCell*)cell).missionDescription.text =[self.notificationArray[indexPath.row] description];
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
            }
            
            [((MissionTableViewCell*)cell) setUserHistory];

        }else if([self.notificationArray[indexPath.row] isKindOfClass:[Friendship class]]){
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FriendTableViewCell" owner:self options:nil];
            cell = (FriendTableViewCell*)[topLevelObjects objectAtIndex:0];
            
            if([self.notificationArray[indexPath.row] accepted]){
                [((FriendTableViewCell*)cell) wasDecided];
            }else{
                [((FriendTableViewCell*)cell) wasNotDecided];
            }
                ((FriendTableViewCell*)cell).receiverName.text = [self.notificationArray[indexPath.row] acceptUserName] ;
            ((FriendTableViewCell*)cell).requestorName.text = [self.notificationArray[indexPath.row] requestUserName];
            
            if([[PhotoCache photoDictionary] objectForKey:[self.notificationArray[indexPath.row] acceptUserId]]){
                ((FriendTableViewCell*)cell).receiverPicture.image =[[PhotoCache photoDictionary] objectForKey:[self.notificationArray[indexPath.row] acceptUserId]];
                
            }
            else{
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Success! Include your code to handle the results here
                        ((FriendTableViewCell*)cell).receiverPicture.image = [[UIImage alloc] initWithData:
                                                                           [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", [self.notificationArray[indexPath.row] acceptUserId]]]]
                                                                           ];
                        //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                        [[PhotoCache photoDictionary] setObject:((FriendTableViewCell*)cell).receiverPicture.image forKey:[self.notificationArray[indexPath.row] acceptUserId]];
                        NSLog(@"loading a new picture");
                    } else {
                        // An error occurred, we need to handle the error
                        // See: https://developers.facebook.com/docs/ios/errors
                    }
                }];
            }
            
            if([[PhotoCache photoDictionary] objectForKey:[self.notificationArray[indexPath.row] requestUserId]]){
                ((FriendTableViewCell*)cell).requestorPicture.image =[[PhotoCache photoDictionary] objectForKey:[self.notificationArray[indexPath.row] requestUserId]];
                
            }
            else{
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Success! Include your code to handle the results here
                        ((FriendTableViewCell*)cell).requestorPicture.image = [[UIImage alloc] initWithData:
                                                                              [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", [self.notificationArray[indexPath.row] requestUserId]]]]
                                                                              ];
                        //                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                        [[PhotoCache photoDictionary] setObject:((FriendTableViewCell*)cell).requestorPicture.image forKey:[self.notificationArray[indexPath.row] requestUserId]];
                        NSLog(@"loading a new picture");
                    } else {
                        // An error occurred, we need to handle the error
                        // See: https://developers.facebook.com/docs/ios/errors
                    }
                }];
            }

        }
    }
//    cell.textLabel.text = @"Notifications";
    
    return cell;
}

-(UIImage*)getCallOrCacheImage:(NSString*)user_id{
    __block UIImage *image;
    if([[PhotoCache photoDictionary] objectForKey:user_id]){
        image =[[PhotoCache photoDictionary] objectForKey:user_id];
        
    }
    else{
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                // Success! Include your code to handle the results here
                image = [[UIImage alloc] initWithData:
                                                                  [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", user_id]]]
                                                                  ];
//                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                [[PhotoCache photoDictionary] setObject:image forKey:user_id];
                NSLog(@"loading a new picture");
            } else {
                // An error occurred, we need to handle the error
                // See: https://developers.facebook.com/docs/ios/errors
            }
        }];
    }
    return image;
//    else{
//        __block UIImage* userpic;
//        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//            if (!error) {
//                // Success! Include your code to handle the results here
//               userpic = [[UIImage alloc] initWithData:
//                                                                  [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", user_id]]]
//                                                                  ];
//                
//                [[PhotoCache photoDictionary] setObject:userpic forKey:user_id];
//               
//                NSLog(@"loading a new picture");
//            } else {
//                // An error occurred, we need to handle the error
//                // See: https://developers.facebook.com/docs/ios/errors
//            }
//        }];
//        
//    }
}


@end
