//
//  ViewMissionViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/24/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "ViewMissionViewController.h"
#import "PhotoCache.h"
#import "CommentView.h"
#import "AppDelegate.h"
@interface ViewMissionViewController ()
{
    NSMutableData *_downloadedData;
}
@end

@implementation ViewMissionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.commentPress = NO;
    }
    return self;
}

-(id)initWithMission:(Missions*)m{
    self = [super init];
    if (self) {
        // Custom initialization
        self.mission = m;
        self.commentPress = NO;
        [self startDownloadingComments];
        self.commentList = [[NSMutableArray alloc]init];
    }
    return self;
}



-(void)keyboardDidShow{
    [self.scrollView setContentOffset:CGPointMake( 0,100) animated:YES];

}


- (IBAction)postComment:(id)sender {
    NSLog(@"post commet ");
    if(self.mission.missionId != nil){
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *post = [NSString stringWithFormat:@"user_id=%@&mission_id=%@&comment_text=%@",appDelegate.masterTabBarViewController.userData.user_id, self.mission.missionId,self.commentTextField.text];
        NSLog(@"commet %@",post);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
        // Download the json file
        NSURL *jsonFileUrl = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/userCommented.php"];
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
    [self dismissKeyboard];
    [self.commentTextField setText:@""];

}



-(void)keyboardDidHide{
//    [self.scrollView setContentOffset:CGPointMake(0,-30) animated:YES];
}

-(void)dismissKeyboard {
    [self.commentTextField resignFirstResponder];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self populateComments];
    
    [self.missionDescription setUserInteractionEnabled:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize = CGSizeMake(320, 1000);

    
    self.scrollView.delegate= self;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.scrollView setScrollEnabled:YES];

    [self.scrollView addSubview:self.acceptMisionButton];
    [self.scrollView addSubview:self.creatorImage];
    
    [self.scrollView setUserInteractionEnabled:YES];
    self.scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:self.view];
    
    if (self.creatorImage.image == nil && ![[PhotoCache photoDictionary] objectForKey:self.mission.creatorUserId]) {
        
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                // Success! Include your code to handle the results here
    //            NSLog(@"user info: %@", result);
                self.creatorImage.image = [[UIImage alloc] initWithData:
                                           [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large&width=120&height=120", self.mission.creatorUserId]]]
                                           ];
                
            } else {
                // An error occurred, we need to handle the error
                // See: https://developers.facebook.com/docs/ios/errors
            }
        }];
    }else{
        self.creatorImage.image = [[PhotoCache photoDictionary]objectForKey:self.mission.creatorUserId];

    }
    
    self.creatorName.text = self.mission.creatorUserName;
    self.missionDescription.text = self.mission.description;
    
    if([self.mission.completeUserId isEqual:@"0"] || !self.mission.completeUserId){
        self.completedByStaticLabel.hidden = YES;
        self.completorImage.hidden = YES;
        self.completorName.hidden = YES;
    }
    else{
        self.acceptMisionButton.hidden = YES;
        self.missionDescription.hidden = YES;
    }
    
    if(self.commentPress){
        [self.commentTextField becomeFirstResponder];
        self.commentPress = NO;
    }
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([appDelegate.masterTabBarViewController.userData.userLikes.missionLikesDictionary objectForKey:self.mission.missionId]){
        [self.likeButton setEnabled:NO];

    }
    
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // test if our control subview is on-screen
    if (self.commentButton.superview != nil) {
        if ([touch.view isDescendantOfView:self.commentButton]) {
            [self postComment:self.commentButton];
            // we touched our control surface
            return NO; // ignore the touch
        }
    }
    return YES; // handle the touch
}

-(void)populateComments{
    NSLog(@"mision %@",self.mission.missionId);
    CommentView* comment = [[CommentView alloc]initWithFrame:CGRectMake(0, 470, self.view.frame.size.width, 140)];
    [comment.xibCommentView.commentText setText:@"NONNO"];
    [self.scrollView addSubview:comment];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.commentTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)acceptMissionPressed:(id)sender {
}

- (IBAction)likeButtonPressed:(id)sender {
    NSLog(@"liked id: %@",self.mission.missionId);
    [self.likeButton setEnabled:NO];
    [self.likeButton setTitle:@"Liked!" forState:UIControlStateNormal];
    if(self.mission.missionId != nil){
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

        NSString *post = [NSString stringWithFormat:@"user_id=%@&mission_id=%@",appDelegate.masterTabBarViewController.userData.user_id, self.mission.missionId];
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


//====================


-(void)startDownloadingComments{
    NSString *post = [NSString stringWithFormat:@"mission_id=%@",self.mission.missionId];
    NSLog(@"comment post: %@",post);
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/getMissionComments.php"];
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
        NSLog(@"Connection Download Comments Success");
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
    
    NSLog(@"json array %@",jsonArray);
    
//    //Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        if([jsonElement[@"type"] isEqualToString:@"mission_comment"]){
            CommentView* comment = [[CommentView alloc]initWithFrame:CGRectMake(0, 470+[self.commentList count]*150, self.view.frame.size.width, 140)];
            [comment.xibCommentView.commentText setText:jsonElement[@"comment_text"]];
             comment.xibCommentView.nameLabel.text = jsonElement[@"comment_user_id"];
             
             [self.commentList addObject:comment];
            [self.scrollView addSubview:comment];
        }
        
    }
    
    
    NSLog(@"finish downloading user data initially");
    
}




@end
