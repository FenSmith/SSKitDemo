//
//  DTBUserModel.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/9.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , DTBUserType) {
    DTBUserTypeMan = 0,
    DTBUserTypeFemale = 1,
    DTBUserTypeUnknow = 2,
};

@interface DTBUserModel : NSObject

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic) DTBUserType gender;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,strong) NSNumber *level;
@property (nonatomic) BOOL is_valid;
@property (nonatomic,copy) NSString *avator;

@end
