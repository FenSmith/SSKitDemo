//
//  UILabel+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SSKit)

+ (UILabel *)labelAddTextColor:(UIColor *)color alsoFont:(CGFloat)font;
+ (UILabel *)labelAddHexColor:(NSString *)color alsoFont:(CGFloat)font;
+ (UILabel *)labelAddTextColor:(UIColor *)color alsoAlpha:(CGFloat)alpha alsoFont:(CGFloat)font;


@end
