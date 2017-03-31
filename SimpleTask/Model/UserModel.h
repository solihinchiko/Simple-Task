//
//  UserModel.h
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property NSString *profilePicture;
@property NSString *emailAddress;
@property NSString *fullname;

+ (UserModel *)userFromFBDictionary:(NSDictionary *)dict;

@end
