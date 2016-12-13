//
//  DTBRequestManager.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/10.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBRequestManager.h"

@implementation DTBRequestManager

+ (DTBRequestManager *)sharedManager {
    static DTBRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DTBRequestManager alloc] init];
    });
    return manager;
}

- (RACSignal *)requestUserRegistCaptcha:(NSString *)phone {
    return [[SSRequestService sharedRequest] requestPOSTWithURL:@"login/regist_captcha" alsoParams:@{@"phone":phone}];
}

- (RACSignal *)requestUserRegist:(NSString *)phone captcha:(NSString *)captcha username:(NSString *)username password:(NSString *)password {
    return [[SSRequestService sharedRequest] requestPOSTWithURL:@"login/regist" alsoParams:@{@"phone":phone,
                                                                                             @"captcha":captcha,
                                                                                             @"username":username,
                                                                                             @"password":password}];
}

- (RACSignal *)requestUserLogin:(NSString *)username password:(NSString *)password {
    return [[SSRequestService sharedRequest] requestPOSTWithURL:@"login/login" alsoParams:@{@"username":username,
                                                                                            @"password":password}];
}

- (RACSignal *)requestVideosWithPage:(NSInteger)page {
    return [[SSRequestService sharedRequest] requestPOSTWithURL:@"video/videos" alsoParams:@{@"page":@(page)}];
}

- (RACSignal *)requestCommentsWithVideoid:(NSString *)videoid page:(NSInteger)page {
    return [[SSRequestService sharedRequest] requestPOSTWithURL:@"comment/comments" alsoParams:@{@"page":@(page),
                                                                                                 @"videoid":videoid}];
}

- (RACSignal *)requestReplysWithCommentid:(NSString *)commentid page:(NSInteger)page {
    return [[SSRequestService sharedRequest] requestPOSTWithURL:@"comment/subComments" alsoParams:@{@"page":@(page),
                                                                                                    @"commentid":commentid}];

}

- (RACSignal *)submitUserComment:(NSString *)comment {
    return [[SSRequestService sharedRequest] requestPOSTWithURL:@"comment/addComment" alsoParams:@{@"comments":comment}];
}

- (RACSignal *)requestCommunityCommentsAttachPage:(NSInteger)page {
    return [[SSRequestService sharedRequest] requestPOSTWithURL:@"community/comments" alsoParams:@{@"page":@(page)}];
}

@end
