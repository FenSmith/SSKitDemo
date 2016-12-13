//
//  SSAlertViewConfig.h
//  SSAlertViewDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSAlertViewConfig : NSObject

/**
 标题的字体颜色
 */
+ (UIColor *)ssav_titleLabelTextColor;

/**
 详情的字体颜色
 */
+ (UIColor *)ssav_contentLabelTextColor;

/**
 详情与按钮之间的间隔横线
 */
+ (UIColor *)ssav_spliterColor;

/**
 按钮之间分隔的横线
 */
+ (UIColor *)ssav_optionSpliterColor;

/**
 普通按钮的颜色属性
 */
+ (UIFont *)ssav_normalOptFont;
+ (UIColor *)ssav_normalOptTextColor;
+ (UIColor *)ssav_normalOptBackgroundColor;
+ (UIColor *)ssav_normalOptHighlightBackgroundColor;

/**
 取消按钮的颜色属性
 */
+ (UIFont *)ssav_cancelOptFont;
+ (UIColor *)ssav_cancelOptTextColor;
+ (UIColor *)ssav_cancelOptBackgroundColor;
+ (UIColor *)ssav_cancelOptHighlightBackgroundColor;

/**
 设置属性
 */
+ (void)ssav_setTitleLabelTextColor:(NSString *)color;
+ (void)ssav_setContentLabelTextColor:(NSString *)color;
+ (void)ssav_setSpliterTextColor:(NSString *)color;
+ (void)ssav_setOptionSpliterTextColor:(NSString *)color;
+ (void)ssav_setNormalOptFont:(CGFloat)font;
+ (void)ssav_setNormalOptTextColor:(NSString *)color;
+ (void)ssav_setNormalOptBackgroundColor:(NSString *)color;
+ (void)ssav_setNormalOptHighlightBackgroundColor:(NSString *)color;
+ (void)ssav_setCancelOptFont:(CGFloat)font;
+ (void)ssav_setCancelOptTextColor:(NSString *)color;
+ (void)ssav_setCancelOptBackgroundColor:(NSString *)color;
+ (void)ssav_setCancelOptHighlightBackgroundColor:(NSString *)color;

@end
