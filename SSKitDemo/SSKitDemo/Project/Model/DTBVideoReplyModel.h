//
//  DTBVideoReplyModel.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/13.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTBVideoReplyModel : NSObject

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic,strong) DTBUserModel *user;
@property (nonatomic,strong) DTBVideoReplyModel *comment;
@property (nonatomic,strong) NSNumber *likes;
@property (nonatomic) NSTimeInterval createTime;

@end
