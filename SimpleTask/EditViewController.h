//
//  EditViewController.h
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"

@interface EditViewController : UIViewController

@property (strong, nonatomic) TaskModel *task;
@property (strong, nonatomic) NSString *stringTitle;
@property int index;
@property (weak, nonatomic) IBOutlet UITextField *textfieldTask;
@property (weak, nonatomic) IBOutlet UITextField *textfieldDescription;


@end
