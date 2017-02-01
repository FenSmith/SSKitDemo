//
//  UIButton+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SSKit)

/**
 按钮默认样式
 */
+ (UIButton *)buttonAddTitleColor:(UIColor *)titleColor alsoFont:(NSInteger)font;
+ (UIButton *)buttonAddTitleColorHex:(NSString *)colorHex alsoFont:(NSInteger)font;

/**
 设置背景颜色
 */
- (void)buttonAddTouchColorWithNormalState:(UIColor *)colorNormal alsoHighlightedColor:(UIColor *)colorHighlighted;
- (void)buttonAddTouchColorWithNormalHex:(NSString *)normalHex alsoHighlightedHex:(NSString *)highlightedHex;

- (void)buttonAddContentAlignmentLeftWithPadding:(CGFloat)padding;

+ (UIButton *)buttonAddImage:(NSString *)image;

@end
