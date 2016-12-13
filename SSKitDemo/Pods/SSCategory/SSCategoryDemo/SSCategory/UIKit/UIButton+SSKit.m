//
//  UIButton+SSKit.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UIButton+SSKit.h"
#import "UIColor+SSKit.h"

@implementation UIButton (SSKit)

+ (UIButton *)buttonAddTitleColor:(UIColor *)titleColor alsoFont:(NSInteger)font {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (titleColor) {
        [button setTitleColor:titleColor forState:0];
    }
    [button.titleLabel setFont:[UIFont systemFontOfSize:font]];
    return button;
}

+ (UIButton *)buttonAddTitleColorHex:(NSString *)colorHex alsoFont:(NSInteger)font {
    return [self buttonAddTitleColor:[UIColor colorWithHexString:colorHex] alsoFont:font];
}

- (void)buttonAddTouchColorWithNormalState:(UIColor *)colorNormal alsoHighlightedColor:(UIColor *)colorHighlighted {
    [self setBackgroundImage:colorNormal.colorImage forState:0];
    [self setBackgroundImage:colorHighlighted.colorImage forState:1<<0];
}

- (void)buttonAddTouchColorWithNormalHex:(NSString *)normalHex alsoHighlightedHex:(NSString *)highlightedHex {
    [self buttonAddTouchColorWithNormalState:[UIColor colorWithHexString:normalHex] alsoHighlightedColor:[UIColor colorWithHexString:highlightedHex]];
}

- (void)buttonAddContentAlignmentLeftWithPadding:(CGFloat)padding {
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self setContentEdgeInsets:UIEdgeInsetsMake(0, padding, 0, 0)];
}

+ (UIButton *)buttonAddImage:(NSString *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:0];
    return button;
}

@end
