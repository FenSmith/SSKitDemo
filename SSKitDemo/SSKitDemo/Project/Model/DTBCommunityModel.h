//
//  DTBCommunityModel.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/31.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTBUserModel.h"

@interface DTBCommunityModel : NSObject

@property (nonatomic,copy) NSString *id;
@property (nonatomic,strong) DTBUserModel *user;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *title;
@property (nonatomic) NSTimeInterval createTime;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSNumber *replys;
@property (nonatomic,strong) NSNumber *watchs;

@end
