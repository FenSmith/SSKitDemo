//
//  SSTabbarWrapper.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/28.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SSTabbarBadgeType) {
    //显示具体的数字
    SSTabbarBadgeTypeNumber = 0,
    //只显示纯色
    SSTabbarBadgeTypeColor = 1,
};

typedef NS_ENUM(NSInteger , SSTabbarWrapperState) {
    SSTabbarWrapperStateNormal = 0,
    SSTabbarWrapperStateHighlight = 1 << 0,
    SSTabbarWrapperStateDisable = 1 << 1,
    SSTabbarWrapperStateSelected = 1 << 2,
};

#define SSTWStringify(x) #x

static inline NSString* SSTabbarWrapperStateString(SSTabbarWrapperState state) {
#define SSTWCASE(x) case SSTabbarWrapperState ## x : return @SSTWStringify(SSTabbarWrapperState ## x ## Key);
    switch (state) {
            SSTWCASE(Normal);
            SSTWCASE(Highlight);
            SSTWCASE(Disable);
            SSTWCASE(Selected);
    }
#undef SSTWCASE
}

@interface SSTabbarWrapper : UIControl

/**
 自定义控件的尺寸
 如果控件宽度为‘0’, 则这个控件的宽度与其他同为‘0’宽度的控件平分剩余的宽度
 如果控件高度为‘0’, 则这个控件的高度与‘Tabbar’的高度相同
 */
@property (nonatomic) CGSize wrapperSize;

/**
 自定义空间中的图片尺寸
 */
@property (nonatomic) CGSize wrapperImageSize;

/**
 角标相关
 badgeSize：角标的尺寸，默认大小为CGSizeMake(18,18)
 badgeEdgeInsets：角标的内边距，默认大小为UIEdgeInset(5,0,0,5)
 badgeAttributes：当角标类型为时，角标的属性，默认为 ‘白色’, ‘14号字体’
 */
@property (nonatomic) SSTabbarBadgeType badgeType;
@property (nonatomic,strong) UIColor *badgeFillColor;
@property (nonatomic) CGSize badgeSize;
@property (nonatomic) UIEdgeInsets badgeEdgeInsets;
@property (nonatomic,strong) NSDictionary *badgeAttributes;
- (void)resetWrapperBadgeValue:(NSInteger)badgeValue;

/**
 设置实例的部分边上的圆弧半径
 适用于特殊的形状，例如只有左右上半部分两边有圆弧，而下班部分没有
 */
- (void)resetCornerRadius:(CGFloat)cornerRadius forCorners:(UIRectCorner)corners;

/**
 设置实例的不同状态下的图片与文字
 如果文字不存在, 则图片会充满整个控件
 */
- (void)setWrapperImage:(NSString *)image withText:(NSString *)text forControlState:(SSTabbarWrapperState)state;

/**
 设置实例的不同状态下的字体的样式
 默认字体大小‘12’
 */
- (void)setWrapperTextAttributes:(NSDictionary *)attributes forControlState:(SSTabbarWrapperState)state;

/**
 设置实例的不同状态下的背景颜色
 */
- (void)setWrapperBackgroundColor:(UIColor *)backgroundColor forControlState:(SSTabbarWrapperState)state;

@end
