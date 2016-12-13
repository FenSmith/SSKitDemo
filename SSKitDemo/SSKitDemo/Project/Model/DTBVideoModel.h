//
//  DTBVideoModel.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTBVideoModel : NSObject

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *linkurl;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic) NSInteger createTime;
@property (nonatomic,strong) NSNumber *comments;
@property (nonatomic,strong) NSNumber *likes;
@property (nonatomic,strong) NSNumber *stores;

@end
