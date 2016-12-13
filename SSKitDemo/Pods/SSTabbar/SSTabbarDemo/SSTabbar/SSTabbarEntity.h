//
//  SSTabbarEntity.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/28.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SSTabbarBadgeType) {
    SSTabbarBadgeTypeColor = 0, ///> 只显示纯色
    SSTabbarBadgeTypeNumber = 1, ///> 显示具体的数字
};

@interface SSTabbarEntity : UIControl

/**
 如果控件宽度为‘0’, 则这个控件的宽度与其他同为‘0’宽度的控件平分剩余的宽度
 如果控件高度为‘0’, 则这个控件的高度与‘Tabbar’的高度相同
 */
@property (nonatomic) CGSize entitySize;
@property (nonatomic) CGSize imageSize; // 只包含一个图片的时候,设定的图片尺寸

@property (nonatomic) NSInteger badgeValue;
@property (nonatomic) SSTabbarBadgeType badgeType;
@property (nonatomic,strong) UIColor *badgeTintColor; // 默认为 ‘[UIColor redColor]’
@property (nonatomic) CGSize badgeSize; // 默认为 ‘CGSizeMake(18,18)’
@property (nonatomic) UIEdgeInsets badgeEdgeInsets; // 默认为 ‘UIEdgeInset(5,0,0,5)’
@property (nonatomic,strong) NSDictionary *badgeAttributes; // 默认为 ‘白色’, ‘14号字体’

- (void)resetBadgeValue:(NSInteger)badgeValue;

/**
 如果文字不存在, 则图片会充满整个控件, 且‘rectImage’ 与 ‘rectText’无效
 */
- (void)setImage:(NSString *)image alsoText:(NSString *)text forControlState:(UIControlState)state;

/**
 设置字体的样式
 默认字体大小‘12’
 */
- (void)setTextAttributes:(NSDictionary *)attributes forControlState:(UIControlState)state;
- (void)setBackgroundColor:(UIColor *)backgroundColor forControlState:(UIControlState)state;

- (void)resetCornerRadius:(CGFloat)cornerRadius alsoCorners:(UIRectCorner)corners;

@end
