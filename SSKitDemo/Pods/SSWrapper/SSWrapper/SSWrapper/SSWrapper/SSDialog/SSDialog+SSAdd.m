//
//  SSDialog+SSAdd.m
//  SSDialogDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSDialog+SSAdd.h"

@implementation SSDialog (SSAdd)

+ (void)showDialogWithType:(SSDialogType)type forDetail:(NSString *)detail {
    [self showDialogWithType:type forDetail:detail inView:nil];
}

+ (void)showDialogWithType:(SSDialogType)type forDetail:(NSString *)detail inView:(UIView *)view {
    [self showDialogWithType:type forDetail:detail durationDelay:2.0f fetchCallback:nil inView:view];
}

+ (void)showDialogForDetail:(NSString *)detail {
    [self showDialogWithType:SSDialogTypeWaitCover forDetail:detail durationDelay:MAXFLOAT fetchCallback:nil inView:nil];
}

+ (void)showDialogWithType:(SSDialogType)type forDetail:(NSString *)detail durationDelay:(NSTimeInterval)delay fetchCallback:(ssdl_timerFinishCallback)callback inView:(UIView *)view {
    __block SSDialog *dialog = nil;
    
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    [view.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if ([subView isKindOfClass:[SSDialog class]]) {
            [(SSDialog *)subView close];
        }
    }];
    
    if (dialog == nil) {
        dialog = [[SSDialog alloc] init];
    }
    
    if (dialog.autoHiddenTimer) {
        [dialog.autoHiddenTimer invalidate];
        dialog.autoHiddenTimer = nil;
    }
    
    dialog.type = type;
    dialog.detailLabel.text = detail;
    dialog.autoHiddenTimeInterval = delay;
    dialog.callback = callback;
    [dialog showInView:view];
}

@end
