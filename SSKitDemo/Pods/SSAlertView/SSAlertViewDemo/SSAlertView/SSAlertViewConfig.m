//
//  SSAlertViewConfig.m
//  SSAlertViewDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSAlertViewConfig.h"
#import "UIColor+SSAlertView.h"

static NSString * const ssav_titleLabelTextColor = @"ssav_titleLabelTextColorName";
static NSString * const ssav_contentLabelTextColor = @"ssav_contentLabelTextColorName";
static NSString * const ssav_spliterTextColor = @"ssav_spliterTextColorName";
static NSString * const ssav_optionSpliterTextColor = @"ssav_optionSpliterTextColorName";
static NSString * const ssav_normalOptFont = @"ssav_normalOptFontName";
static NSString * const ssav_normalOptTextColor = @"ssav_normalOptTextColorName";
static NSString * const ssav_normalOptBackgroundColor = @"ssav_normalOptBackgroundColorName";
static NSString * const ssav_normalOptHighlightBackgroundColor = @"ssav_normalOptHighlightBackgroundColorName";
static NSString * const ssav_cancelOptFont = @"ssav_cancelOptFontName";
static NSString * const ssav_cancelOptTextColor = @"ssav_cancelOptTextColorName";
static NSString * const ssav_cancelOptBackgroundColor = @"ssav_cancelOptBackgroundColorName";
static NSString * const ssav_cancelOptHighlightBackgroundColor = @"ssav_cancelOptHighlightBackgroundColorName";

@implementation SSAlertViewConfig

+ (UIColor *)ssav_titleLabelTextColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_titleLabelTextColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"1f1f1f"];
}

+ (UIColor *)ssav_contentLabelTextColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_contentLabelTextColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"838282"];
}

+ (UIColor *)ssav_spliterColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_spliterTextColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"e8e8e8"];
}

+ (UIColor *)ssav_optionSpliterColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_optionSpliterTextColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"d2d2d2"];
}

+ (UIFont *)ssav_normalOptFont {
    NSNumber *font = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_normalOptFont];
    if (font) {
        return [UIFont systemFontOfSize:font.floatValue];
    }
    return [UIFont systemFontOfSize:18];
}

+ (UIColor *)ssav_normalOptTextColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_normalOptTextColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor whiteColor];
}

+ (UIColor *)ssav_normalOptBackgroundColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_normalOptBackgroundColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"41dbf5"];
}

+ (UIColor *)ssav_normalOptHighlightBackgroundColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_normalOptHighlightBackgroundColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"2fc9e4"];
}

+ (UIFont *)ssav_cancelOptFont {
    NSNumber *font = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_cancelOptFont];
    if (font) {
        return [UIFont systemFontOfSize:font.floatValue];
    }
    return [UIFont systemFontOfSize:18];
}

+ (UIColor *)ssav_cancelOptTextColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_cancelOptTextColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"848484"];
}

+ (UIColor *)ssav_cancelOptBackgroundColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_cancelOptBackgroundColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"e9e9e9"];
}

+ (UIColor *)ssav_cancelOptHighlightBackgroundColor {
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:ssav_cancelOptHighlightBackgroundColor];
    if (color) {
        return [UIColor ssav_hexColor:color];
    }
    return [UIColor ssav_hexColor:@"d6d6d6"];
}

+ (void)ssav_setTitleLabelTextColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_titleLabelTextColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setContentLabelTextColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_contentLabelTextColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setSpliterTextColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_spliterTextColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setOptionSpliterTextColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_optionSpliterTextColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setNormalOptFont:(CGFloat)font {
    [[NSUserDefaults standardUserDefaults] setObject:@(font) forKey:ssav_normalOptFont];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setNormalOptTextColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_normalOptTextColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setNormalOptBackgroundColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_normalOptBackgroundColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setNormalOptHighlightBackgroundColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_normalOptHighlightBackgroundColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setCancelOptFont:(CGFloat)font {
    [[NSUserDefaults standardUserDefaults] setObject:@(font) forKey:ssav_cancelOptFont];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setCancelOptTextColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_cancelOptTextColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setCancelOptBackgroundColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_cancelOptBackgroundColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)ssav_setCancelOptHighlightBackgroundColor:(NSString *)color {
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:ssav_cancelOptHighlightBackgroundColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
