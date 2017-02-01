//
//  SSDialog+SSAdd.h
//  SSDialogDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSDialog.h"

@interface SSDialog (SSAdd)

/**
 显示一个弹出层
 默认为‘2S’后消失
 */
+ (void)showDialogWithType:(SSDialogType)type forDetail:(NSString *)detail;
+ (void)showDialogWithType:(SSDialogType)type forDetail:(NSString *)detail inView:(UIView *)view;

/**
 显示一个弹出层
 type为‘SSDialogTypeWaitCover’
 */
+ (void)showDialogForDetail:(NSString *)detail;
+ (void)showDialogWithType:(SSDialogType)type forDetail:(NSString *)detail durationDelay:(NSTimeInterval)delay fetchCallback:(ssdl_timerFinishCallback)callback inView:(UIView *)view;

@end
