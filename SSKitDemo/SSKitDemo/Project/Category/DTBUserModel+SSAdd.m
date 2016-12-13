//
//  DTBUserModel+SSAdd.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBUserModel+SSAdd.h"

static NSString * const DTBUserLoginDataKey = @"DTBUserLoginDataKeyName";
static NSString * const DTBUserLoginStatusKey = @"DTBUserLoginStatusKeyName";

@implementation DTBUserModel (HKAdd)

+ (void)insertUserData:(NSDictionary *)data {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:DTBUserLoginDataKey];
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:DTBUserLoginStatusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DTBUserLoginNotification object:nil];
}

+ (BOOL)isUserLogin {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:DTBUserLoginStatusKey] boolValue];
}

+ (void)clearUserData {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:DTBUserLoginDataKey];
    [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:DTBUserLoginStatusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DTBUserLogoutNotification object:nil];
}

+ (DTBUserModel *)user {
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:DTBUserLoginDataKey];
    return [DTBUserModel yy_modelWithDictionary:data];
}

@end
