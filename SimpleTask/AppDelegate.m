//
//  AppDelegate.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "AppDelegate.h"
#import "TaskViewController.h"
#import "LeftViewController.h"
#import "SWRevealViewController.h"
#import "UserModel.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate () <SWRevealViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //Facebook Function
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    self.loginViewController = [[LoginViewController alloc] init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TaskViewController *frontViewController = (TaskViewController *) [storyboard instantiateViewControllerWithIdentifier:@"TaskViewController"];
    LeftViewController *rearViewController = (LeftViewController *) [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];

    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    
    self.viewController = revealController;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UserModel *user = [UserModel userFromFBDictionary:[defaults objectForKey:@"USER"]];
    
    if (user.fullname.length > 0) {
        [self.window setRootViewController:self.viewController];
    } else {
        [self.window setRootViewController:self.loginViewController];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}


- (void)goToTaskViewController {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TaskViewController *frontViewController = (TaskViewController *) [storyboard instantiateViewControllerWithIdentifier:@"TaskViewController"];
    LeftViewController *rearViewController = (LeftViewController *) [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    
    self.viewController = revealController;
    
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ self.window.rootViewController = self.viewController; }
                    completion:nil];
    
}

- (void)goToLoginController {
    self.loginViewController = [[LoginViewController alloc] init];
    
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ self.window.rootViewController = self.loginViewController; }
                    completion:nil];
}


@end
