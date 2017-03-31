//
//  Utility.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (Utility *)sharedUtility {
    static Utility *_sharedUtility = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedUtility = [[Utility alloc] init];
    });
    
    return _sharedUtility;
}

#pragma mark - Date
- (NSString *)DateToString:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:date];
}

@end
