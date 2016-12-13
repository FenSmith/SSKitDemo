//
//  SSDialog+SSAdd.m
//  SSDialogDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSDialog+SSAdd.h"

@implementation SSDialog (SSAdd)

+ (void)showDialogWithType:(SSDialogType)type details:(NSString *)str {
    [self showDialogWithType:type details:str targetView:nil];
}

+ (void)showDialogWithType:(SSDialogType)type details:(NSString *)str targetView:(UIView *)view {
    [self showDialogWithType:type details:str delayTimeInterval:2.0f callback:nil targetView:view];
}

+ (void)showDialogWithDetails:(NSString *)str {
    [self showDialogWithType:SSDialogTypeWaitCover details:str delayTimeInterval:MAXFLOAT callback:nil targetView:nil];
}

+ (void)showDialogWithType:(SSDialogType)type details:(NSString *)str delayTimeInterval:(NSTimeInterval)delay callback:(ssdl_timerFinishCallback)callback targetView:(UIView *)view {
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
        [dialog.autoHiddenTimer invalidate]; dialog.autoHiddenTimer = nil;
    }
    
    dialog.type = type;
    dialog.detailLabel.text = str;
    dialog.autoHiddenTimeInterval = delay;
    dialog.callback = callback;
    [dialog showInView:view];
}

@end
