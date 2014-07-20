//
//  AddMissionViewController.m
//  SuperYou
//
//  Created by Andrew Han on 6/19/14.
//  Copyright (c) 2014 PandaLab. All rights reserved.
//

#import "AddMissionViewController.h"
#import "UserData.h"
#import "AppDelegate.h"
@interface AddMissionViewController ()

@end

@implementation AddMissionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.profilePictureView.image = appDelegate.masterTabBarViewController.userData.profile_picture;
    self.descriptionField.delegate = self;
    
    self.descriptionField.text = @"Place your mission description here";
    self.descriptionField.textColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelAddMission:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)postMission:(id)sender{
    [self postMissionToServer];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)dismissKeyboard {
    [self.descriptionField resignFirstResponder];
    if(self.descriptionField.text.length ==0){
        self.descriptionField.textColor = [UIColor lightGrayColor];
        self.descriptionField.text = @"Place your mission description here";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(self.descriptionField.text.length ==0){
        self.descriptionField.textColor = [UIColor lightGrayColor];
        self.descriptionField.text = @"Place your mission description here";
    }
    return YES;
}

- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange: (NSRange) range replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(self.descriptionField.text.length ==0){
            self.descriptionField.textColor = [UIColor lightGrayColor];
            self.descriptionField.text = @"Place your mission description here";
        }
        return NO;
    }
    return YES;
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:[NSString stringWithFormat:@"Place your mission description here"]]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}


-(void)postMissionToServer{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *post = [NSString stringWithFormat:@"description=%@&creator_user_id=%@", self.descriptionField.text,appDelegate.masterTabBarViewController.userData.user_id];

    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
//    NSString *postLength = [NSString stringWithFormat:@"%d", [post length]];
    NSURL *url = [NSURL URLWithString:@"http://www.helloandrewhan.com/superyou/addMission.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request addValue:[NSString stringWithFormat:@"%d",postData.length] forHTTPHeaderField:@"Content-Length"];

    //initialize an NSURLConnection  with the request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
//        NSLog(@"Connection Failed");
    }
    else{
//        NSLog(@"Connection Success");
    }
}

@end
