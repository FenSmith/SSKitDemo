//
//  SSErrorHandler.m
//  SSKit
//
//  Created by Quincy Yan on 16/1/1.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSErrorHandler.h"
#import <SSWrapper/SSDialog+SSAdd.h>

@implementation SSErrorHandler

+ (void)errorHandlerWithError:(NSError *)error {
    [self errorHandlerWithError:error showInView:nil];
}

+ (void)errorHandlerWithError:(NSError *)error msg:(NSString *)msg {
    [self errorHandlerWithError:error msg:msg showInView:nil];
}

+ (void)errorHandlerWithError:(NSError *)error showInView:(UIView *)inView {
    [self errorHandlerWithError:error msg:error.userInfo[@"msg"] showInView:inView];
}

+ (void)errorHandlerWithError:(NSError *)error msg:(NSString *)msg showInView:(UIView *)inView {
    NSInteger code = error.code;
    if (code == 1) {
        return;
    }
    
    if ([self isNetworkError:error]) {
        [SSDialog showDialogWithType:SSDialogTypeAlert forDetail:@"网络连接异常" inView:inView];
    } else {
        if ([msg isKindOfClass:[NSNull class]]) {
            [SSDialog showDialogWithType:SSDialogTypeAlert forDetail:@"服务器出错" inView:inView];
            return;
        }
        if (!msg || msg.length == 0) {
            msg = error.localizedDescription;
        }
        [SSDialog showDialogWithType:SSDialogTypeAlert forDetail:msg inView:inView];
    }
}

+ (BOOL)isNetworkError:(NSError *)error {
    NSInteger code = error.code;
    if (code == -1001 || code == -1003 || code == -1009 || code == -1005) {
        return YES;
    }
    return NO;
}

@end
