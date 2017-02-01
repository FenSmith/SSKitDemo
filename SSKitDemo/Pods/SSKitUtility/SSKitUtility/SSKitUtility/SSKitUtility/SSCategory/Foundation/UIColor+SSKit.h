//
//  UIColor+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGBBytes(r,g,b) [UIColor \
colorWithRed:   ((CGFloat)(r)/255.0) \
green:          ((CGFloat)(g)/255.0) \
blue:           ((CGFloat)(b)/255.0) \
alpha:          1.0]

#define UIColorFromRGBHex(rgbValue) [UIColor \
colorWithRed:   ((CGFloat)(((rgbValue) & 0xFF0000) >> 16))/255.0 \
green:          ((CGFloat)(((rgbValue) & 0xFF00) >> 8))/255.0 \
blue:           ((CGFloat) ((rgbValue) & 0xFF))/255.0 \
alpha:          1.0]

@interface UIColor (SSKit)

/**
 十六进制转化UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 颜色转化成UIImage
 */
- (UIImage *)colorImage;
- (UIImage *)colorImageWithSize:(CGSize)specSize;

+ (UIColor *)colorWithRGB:(NSString *)RGBString;

@end
