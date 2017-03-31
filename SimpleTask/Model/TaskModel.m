//
//  TaskModel.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

+ (TaskModel *)getTaskFromDictionary:(NSDictionary *)dict {
    TaskModel *model = [[TaskModel alloc] init];
    model.title = [dict objectForKey:@"title"];
    model.detail = [dict objectForKey:@"detail"];
    model.dueDate = [dict objectForKey:@"dueDate"];
    return model;
}

@end
