//
//  UserModel.m
//  SimpleTask
//
//  Created by Solihin Chiko on 3/31/17.
//  Copyright © 2017 Solihin Chiko. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (UserModel *)userFromFBDictionary:(NSDictionary *)dict {
    UserModel *model = [[UserModel alloc] init];
    model.profilePicture = [[[dict objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
    model.emailAddress = [dict objectForKey:@"email"];
    model.fullname = [dict objectForKey:@"name"];
    return model;
}

@end
