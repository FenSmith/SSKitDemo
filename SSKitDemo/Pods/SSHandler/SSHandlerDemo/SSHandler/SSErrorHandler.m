//
//  SSErrorHandler.m
//  SSKit
//
//  Created by Quincy Yan on 16/1/1.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSErrorHandler.h"
#import <SSDialog/SSDialog+SSAdd.h>

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
        [SSDialog showDialogWithType:SSDialogTypeAlert details:@"网络连接异常" targetView:inView];
    } else {
        if ([msg isKindOfClass:[NSNull class]]) {
            [SSDialog showDialogWithType:SSDialogTypeAlert details:@"服务器出错" targetView:inView];
            return;
        }
        if (!msg || msg.length == 0) {
            msg = error.localizedDescription;
        }
        [SSDialog showDialogWithType:SSDialogTypeAlert details:msg targetView:inView];
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
