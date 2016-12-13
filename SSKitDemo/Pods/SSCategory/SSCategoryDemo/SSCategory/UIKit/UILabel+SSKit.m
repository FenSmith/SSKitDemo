//
//  UILabel+SSKit.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UILabel+SSKit.h"
#import "UIColor+SSKit.h"

@implementation UILabel (SSKit)

+ (UILabel *)labelAddTextColor:(UIColor *)color alsoFont:(CGFloat)font {
    UILabel *label = [[UILabel alloc] init];
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = [UIFont systemFontOfSize:font];
    }
    return label;
}

+ (UILabel *)labelAddTextColor:(UIColor *)color alsoAlpha:(CGFloat)alpha alsoFont:(CGFloat)font {
    return [self labelAddTextColor:[color colorWithAlphaComponent:alpha] alsoFont:font];
}

+ (UILabel *)labelAddHexColor:(NSString *)color alsoFont:(CGFloat)font {
    return [self labelAddTextColor:[UIColor colorWithHexString:color] alsoFont:font];
}

@end
