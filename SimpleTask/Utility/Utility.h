//
//  Utility.h
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (Utility *)sharedUtility;

- (NSString *)DateToString:(NSDate *)date;

@end
