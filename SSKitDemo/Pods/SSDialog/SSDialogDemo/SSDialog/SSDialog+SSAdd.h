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
+ (void)showDialogWithType:(SSDialogType)type details:(NSString *)str;
+ (void)showDialogWithType:(SSDialogType)type details:(NSString *)str targetView:(UIView *)view;

/**
 显示一个弹出层
 type为‘SSDialogTypeWaitCover’
 */
+ (void)showDialogWithDetails:(NSString *)str;
+ (void)showDialogWithType:(SSDialogType)type details:(NSString *)str delayTimeInterval:(NSTimeInterval)delay callback:(ssdl_timerFinishCallback)callback targetView:(UIView *)view;

@end
