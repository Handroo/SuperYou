//
//  MissionsHomeViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/9/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "MissionsHomeViewController.h"
#import "MissionsNaviViewController.h"
#import "MissionTableViewCell.h"
#import "ViewMissionViewController.h"
#import "PhotoCache.h"
#import "AppDelegate.h"
@interface MissionsHomeViewController()
{
    NSMutableData *_downloadedData;
}
@end



@implementation MissionsHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userdata:(UserData *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userData = data;
        [self downloadMissionItems];
        self.navigationItem.title = @"Missions";
        [self setMapBarButton];
        self.pictureStorage = [[NSMutableDictionary alloc]init];
        
    }
    return self;
}
-(void)switchToMap{
    [(MissionsNaviViewController*)self.navigationController switchViewControllers:2];
}
-(void)setMapBarButton{
    self.menuButton = [[UIBarButtonItem alloc]
                       initWithTitle:@"Map"
                       style:UIBarButtonItemStyleBordered
                       target:self
                       action:@selector(switchToMap)];
    //    self.naviController.navigationItem.leftBarButtonItem = flipButton;
    self.menuButton.tag=1;
    [self.navigationItem setRightBarButtonItem:self.menuButton animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Missions* m = [self packageCellToMission:(MissionTableViewCell*)[tableView cellForRowAtIndexPath:indexPath]];
    
    ViewMissionViewController *view = [[ViewMissionViewController alloc]init];
    view.mission = m;
    
    [self.navigationController pushViewController:view animated:YES];
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

-(void)didSelectComments{
    NSLog(@"did select comments");
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 165;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.receivedJSONArray count];    //count number of row from counting array hear cataGorry is An Array
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell == nil)
    {
        cell = [[MissionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AnIdentifierString"];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MissionTableViewCell" owner:self options:nil];
        cell = (MissionTableViewCell*)[topLevelObjects objectAtIndex:0];
        ((MissionTableViewCell*)cell).superView = self;
    }
    NSDictionary *jsonElement = self.receivedJSONArray[indexPath.row];
 
    ((MissionTableViewCell*)cell).missionId =jsonElement[@"mission_id"];
    ((MissionTableViewCell*)cell).timeCreated.text =jsonElement[@"creation_date"];
    ((MissionTableViewCell*)cell).creatorName.text =jsonElement[@"name"];
    ((MissionTableViewCell*)cell).creatorUserId =jsonElement[@"user_id"];
        ((MissionTableViewCell*)cell).finisherUserId =jsonElement[@"complete_user_id"];
    if([self.pictureStorage objectForKey:jsonElement[@"user_id"]] == nil && ![[PhotoCache photoDictionary] objectForKey:jsonElement[@"user_id"]]){
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                // Success! Include your code to handle the results here
                ((MissionTableViewCell*)cell).creatorPic.image = [[UIImage alloc] initWithData:
                                                                  [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=100&height=100", jsonElement[@"user_id"]]]]
                                                                  ];
                [self.pictureStorage setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                [[PhotoCache photoDictionary] setObject:((MissionTableViewCell*)cell).creatorPic.image forKey:jsonElement[@"user_id"]];
                NSLog(@"loading a new picture");
            } else {
                // An error occurred, we need to handle the error
                // See: https://developers.facebook.com/docs/ios/errors
            }
        }];
    }else{
//        ((MissionTableViewCell*)cell).creatorPic.image = [self.pictureStorage objectForKey:jsonElement[@"user_id"]];
        ((MissionTableViewCell*)cell).creatorPic.image = [[PhotoCache photoDictionary]objectForKey:jsonElement[@"user_id"]];
    }
    
    
    
    if([jsonElement[@"complete_user_id"] isEqual:@"0"]){
        NSLog(@"yes");
        ((MissionTableViewCell*)cell).missionDescription.text =jsonElement[@"description"];
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
    
    
    return cell;
}


- (void)downloadMissionItems
{
    
//    // Download the json file
//    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/getAllMissions.php"];
//    // Create the request
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
//    // Create the NSURLConnection
//    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
//    
//    
//    
//    
//    
    
    
//    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSString *post = [NSString stringWithFormat:@"user_id=%@", appDelegate.masterTabBarViewController.userData.user_id];
    NSString *post = [NSString stringWithFormat:@"user_id=%@", self.userData.user_id];
    NSLog(post);
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];

    NSURL *url = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/getAllMissions.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request addValue:[NSString stringWithFormat:@"%d",postData.length] forHTTPHeaderField:@"Content-Length"];
    //    NSLog(@"%@", post);
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
    NSMutableArray *_user = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    self.receivedJSONArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
     NSLog(@"User ALL MISSIONS: %@",self.receivedJSONArray );
    
    //Loop through Json objects, create question objects and add them to our questions array
//    for (int i = 0; i < jsonArray.count; i++)
//    {
//        NSDictionary *jsonElement = jsonArray[i];
//        
//        // Create a new location object and set its props to JsonElement properties
//        
//        self.userData.name = jsonElement[@"title"];
//        self.userData.user_id = jsonElement[@"description"];
//        self.userData.missions_complete = jsonElement[@"creator_user_id"];
//        self.userData.personal_missions = jsonElement[@"creation_date"];
//        self.userData.friend_count = jsonElement[@"mission_id"];
//        self.userData.friend_count = jsonElement[@"complete_user_id"];
//        self.userData.friend_count = jsonElement[@"completion_date"];
//        
//        
//        // Add this question to the user array
//        [_user addObject:self.userData];
//    }
}



@end
