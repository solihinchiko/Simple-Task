//
//  LeftViewController.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "LeftViewController.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defaults objectForKey:@"USER"];
    
    UserModel *user = [UserModel userFromFBDictionary:dictionary];
    _labelFullname.text = user.fullname;
    _labelEmail.text = user.emailAddress;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:user.profilePicture]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction
- (IBAction)didTapLogoutButton:(id)sender {
    
    FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc] init];
    [fbLoginManager logOut];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"USER"];
//    [defaults removeObjectForKey:@"TASK"];        // open this if you want to delete task also.
    [defaults synchronize];
    
    // back to login
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate goToLoginController];
    
}


@end
