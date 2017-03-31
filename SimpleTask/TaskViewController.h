//
//  TaskViewController.h
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"

@interface TaskViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, LeftViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LeftViewController *leftController;

@end
