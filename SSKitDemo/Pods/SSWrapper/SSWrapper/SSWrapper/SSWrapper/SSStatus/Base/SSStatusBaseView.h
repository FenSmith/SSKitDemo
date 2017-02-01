//
//  SSStatusBaseView.h
//  SSStatusDemo
//
//  Created by Quincy Yan on 2017/1/27.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSStatusBaseView;

typedef NS_ENUM(NSInteger,SSStatusViewType) {
    SSStatusViewTypeEmptyData = 1 << 0,
    SSStatusViewTypeNetworkError = 1 << 1,
    SSStatusViewTypePortError = 1 << 2,
    
    SSStatusViewTypeLoading = 1 << 3,
    
    SSStatusViewTypeSymbolSuccess = 1 << 4,
    SSStatusViewTypeSymbolError = 1 << 5,
    SSStatusViewTypeSymbolAlert = 1 << 6,
};

/**
 用于验证是否点击视图后立刻删除视图
 */
typedef BOOL (^ SSStatusViewRemoveVerifyCallback)();

/**
 点击视图后的回调
 */
typedef void (^ SSStatusViewTapCallback)(SSStatusBaseView *baseView);

@interface SSStatusBaseView : UIView

/**
 用于验证是否点击视图后立刻删除视图
 */
@property (nonatomic,copy) SSStatusViewRemoveVerifyCallback removeVerifyCallback;

/**
 点击视图后的回调
 */
@property (nonatomic,copy) SSStatusViewTapCallback touchCallback;

- (instancetype)initWithTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback;

@end
