//
//  TaskModel.h
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject

@property NSString *title;
@property NSString *detail;
@property NSDate *dueDate;

+ (TaskModel *)getTaskFromDictionary:(NSDictionary *)dict;

@end
