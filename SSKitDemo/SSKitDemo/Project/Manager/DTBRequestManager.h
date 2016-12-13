//
//  DTBRequestManager.h
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/10.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTBRequestManager : NSObject

+ (DTBRequestManager *)sharedManager;

// 获取注册验证码
- (RACSignal *)requestUserRegistCaptcha:(NSString *)phone;

// 注册
- (RACSignal *)requestUserRegist:(NSString *)phone captcha:(NSString *)captcha username:(NSString *)username password:(NSString *)password;

// 登录
- (RACSignal *)requestUserLogin:(NSString *)username password:(NSString *)password;

// 获取视频列表
- (RACSignal *)requestVideosWithPage:(NSInteger)page;

// 获取评论
- (RACSignal *)requestCommentsWithVideoid:(NSString *)videoid page:(NSInteger)page;

// 获取回复信息
- (RACSignal *)requestReplysWithCommentid:(NSString *)commentid page:(NSInteger)page;

// 添加评论
- (RACSignal *)submitUserComment:(NSString *)comment;

// 获取社区中的帖子
- (RACSignal *)requestCommunityCommentsAttachPage:(NSInteger)page;

@end
