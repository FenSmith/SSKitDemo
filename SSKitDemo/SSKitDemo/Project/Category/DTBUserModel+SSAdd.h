//
//  DTBUserModel+SSAdd.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBUserModel.h"

@interface DTBUserModel (SSAdd)

+ (void)insertUserData:(NSDictionary *)data;

+ (BOOL)isUserLogin;

+ (void)clearUserData;

+ (DTBUserModel *)user;

@end
