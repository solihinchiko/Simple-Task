//
//  CustomTableViewCell.h
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"

@interface CustomTableViewCell : UITableViewCell
- (void)configureCell:(TaskModel *)task;
@end
