//
//  CustomTableViewCell.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Utility.h"

@interface CustomTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelDueDate;


@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Function
- (void)configureCell:(TaskModel *)task {
    Utility *utility = [Utility sharedUtility];
    self.labelTitle.text = task.title;
    self.labelDescription.text = task.detail;
    self.labelDueDate.text = [utility DateToString:task.dueDate];
}

#pragma mark - UITextfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
