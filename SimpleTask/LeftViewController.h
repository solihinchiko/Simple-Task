//
//  LeftViewController.h
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewDelegate <NSObject>

- (void)goToLoginViewController;

@end

@interface LeftViewController : UIViewController

@property (nonatomic, strong) id <LeftViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelFullname;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;


@end
