//
//  DTBVideoDetailModel.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/12.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTBUserModel.h"

@interface DTBVideoDetailModel : NSObject

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *userid;
@property (nonatomic,copy) NSString *videoid;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic) NSInteger createTime;
@property (nonatomic,strong) NSNumber *likes;
@property (nonatomic,strong) NSNumber *replys;

@property (nonatomic,strong) DTBUserModel *user;

@end
