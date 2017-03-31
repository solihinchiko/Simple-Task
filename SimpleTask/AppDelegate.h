//
//  AppDelegate.h
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"


@class SWRevealViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) LoginViewController *loginViewController;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property (nonatomic, strong) UINavigationController *taskNavigationController;
- (void)goToTaskViewController;
- (void)goToLoginController;

@end

