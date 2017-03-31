//
//  EditViewController.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController {
    BOOL isEdit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setting
- (void)setSetting {
    
    if (_task) {
        self.textfieldTask.text = _task.title;
        self.textfieldDescription.text = _task.detail;
        isEdit = YES;
    }
    
    self.title = _stringTitle;
    
    [self addNavButton];
}

- (void)addNavButton {
    // button
    UIBarButtonItem *backButton =   [[UIBarButtonItem alloc] initWithTitle:@" Back " style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    // button
    UIBarButtonItem *saveButton =  [[UIBarButtonItem alloc] initWithTitle:@" Save " style:UIBarButtonItemStylePlain target:self action:@selector(didTapSaveButton)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

#pragma mark - IBAction
- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapSaveButton {
    if ([self isComplete]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arrayTask = [[defaults objectForKey:@"TASK"] mutableCopy];
        NSDictionary *task = @{
                               @"title":_textfieldTask.text,
                               @"detail":_textfieldDescription.text,
                               @"dueDate":[NSDate date]
                               };
        
        if (isEdit) {
            [arrayTask removeObjectAtIndex:_index];
            [arrayTask insertObject:task atIndex:_index];
            [defaults removeObjectForKey:@"TASK"];
            [defaults setObject:arrayTask forKey:@"TASK"];
            [defaults synchronize];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            if (arrayTask.count > 0) {
                [array addObjectsFromArray:arrayTask];
            }
            [array addObject:task];
            [defaults setObject:array forKey:@"TASK"];
            [defaults synchronize];
        }
        
//        [defaults synchronize];
        [self didTapBackButton];
        
    } else {
        // ALERT
        [[[UIAlertView alloc] initWithTitle:@"Simple Task"
                                    message:@"All fields is mandtory"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (BOOL)isComplete {
    if (_textfieldTask.text.length > 0 && _textfieldDescription.text.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
