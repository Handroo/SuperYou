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
@interface ViewMissionViewController ()

@end

@implementation ViewMissionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)keyboardDidShow{
    [self.scrollView setContentOffset:CGPointMake( 0,100) animated:YES];

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
    
    [self populateComments];
    
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
        
        self.missionDescription.hidden = YES;
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
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
}
@end
