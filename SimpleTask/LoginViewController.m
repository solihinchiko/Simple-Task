//
//  LoginViewController.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "UserModel.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLoginButton:(id)sender {
    
    [self fblogin];
}



-(void)fblogin{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    if ([UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"fb://"]])
    {
        login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    }
    
    FBSDKLoginManager* lm = [[FBSDKLoginManager alloc] init];
    [lm logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        NSLog(@"RESULT: %@", result);
        [SVProgressHUD show];
        
        if (error)
        {
            [SVProgressHUD dismiss];
            NSLog(@"Unexpected login error: %@", error);
            NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
            NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
            [[[UIAlertView alloc] initWithTitle:alertTitle
                                        message:alertMessage
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
        else
        {
            if(result.token)   // This means if There is current access token.
            {
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                   parameters:@{@"fields": @"picture, name, email"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id fbData, NSError *error) {
                     
                     NSLog(@"FB DATA: %@", fbData);
                     
                     if (!error) {
                         
                         
                         dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                         dispatch_async(queue, ^(void) {
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 
                                 // AUTHORISED
                                 // SEND TOKEN TO SERVER
                                 NSLog(@"FB TOKEN : %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
                                 // code in here...
                                 
                                 
                                 // SAVE DATA
                                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                 [defaults setObject:fbData forKey:@"USER"];
                                 [defaults synchronize];
                                 
                                 // LOGIN
                                 [self doLogin];
                                 
                                 
                             });
                         });
                         
                     }
                     else{
                         [SVProgressHUD dismiss];
                         NSLog(@"%@", [error localizedDescription]);
                         [[[UIAlertView alloc] initWithTitle:@"Simple Task"
                                                     message:[error localizedDescription]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil] show];
                     }
                 }];
            }
            NSLog(@"Login Cancel");
            [SVProgressHUD dismiss];
        }
    }];
}

- (void)doLogin {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate goToTaskViewController];
}


@end
