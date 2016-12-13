//
//  SSAlertView.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/3.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const SSAlertViewOptFont;
UIKIT_EXTERN NSString * const SSAlertViewOptNormalTextColor;
UIKIT_EXTERN NSString * const SSAlertViewOptDisableTextColor;
UIKIT_EXTERN NSString * const SSAlertViewOptHighlightTextColor;
UIKIT_EXTERN NSString * const SSAlertViewOptNormalBackgroundColor;
UIKIT_EXTERN NSString * const SSAlertViewOptDisableTextBackgroundColor;
UIKIT_EXTERN NSString * const SSAlertViewOptHighlightBackgroundColor;

typedef void (^ ssav_selectedCallback)(NSInteger index);

@interface SSAlertView : UIView

@property (nonatomic, strong) UIView *contextView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic) UIEdgeInsets titleInsets;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic) UIEdgeInsets contentInsets;
@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,copy) NSString *cancelStr;

@property (nonatomic,strong) UIView *customView;
@property (nonatomic) CGSize customSize;

@property (nonatomic,strong) NSArray *options;

/**
 是否弹框正在显示着
 */
@property (nonatomic) BOOL isAlertViewVisible;

/**
 是否弹框中的按钮总是竖排
 默认为否
 */
@property (nonatomic) BOOL isAlertViewVertical;

/**
 是否点击按钮后视图依然存在不消失 PS:适用于强制更新
 默认为否
 */
@property (nonatomic) BOOL isAlertViewAlwaysVisible;

/**
 是否隐藏取消按钮
 默认为否
 */
@property (nonatomic) BOOL isAlertViewHiddenCancel;

/**
 是否点击背景视图以取消视图
 默认为否
 */
@property (nonatomic) BOOL isAlertViewTapedClose;

/**
 普通按钮属性
 SSAlertViewOptFont = 18
 SSAlertViewOptNormalTextColor = whiteColor
 SSAlertViewOptNormalBackgroundColor = #41dbf5
 SSAlertViewOptHighlightBackgroundColor = #2fc9e4
 
 取消按钮属性
 SSAlertViewOptFont = 18
 SSAlertViewOptNormalTextColor = #848484
 SSAlertViewOptNormalBackgroundColor = #e9e9e9
 SSAlertViewOptHighlightBackgroundColor = #d6d6d6
 */
@property (nonatomic,strong) NSMutableDictionary *optAttributes;
@property (nonatomic,strong) NSMutableDictionary *cancelAttributes;

/**
 按钮最大高度
 默认为 47
 */
@property (nonatomic) CGFloat optHeight;

/**
 弹框最大宽度
 默认为 260
 */
@property (nonatomic) CGFloat optMaxWidth;
@property (nonatomic,copy) ssav_selectedCallback callback;

- (void)setEnable:(BOOL)enable alsoIndex:(NSInteger)index;

- (void)show;
- (void)showInView:(UIView *)view;
- (void)showActivityIndicatorWithTimeInterval:(NSTimeInterval)afterTime;
- (void)close;

@end
