//
//  UIView+StatusAdd.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSStatusView.h"

typedef NS_ENUM(NSInteger,SSStatusViewType) {
    SSStatusViewTypeEmptyData = 1,
    SSStatusViewTypeNetworkError = 2, ///> 网络异常, 用于超时
    SSStatusViewTypePortError = 3, ///> 请求出错
};

typedef void (^ SSStatusViewCallback)();
typedef BOOL (^ SSStatusViewTouchCallback)();

@interface UIView (StatusAdd)

@property (nonatomic,strong) SSStatusView *statusView;

- (void)showStatusViewWithImage:(NSString *)image alsoDesc:(NSString *)desc alsoCallback:(SSStatusViewCallback)callback isDisplayCallback:(SSStatusViewTouchCallback)isDisplayCallback;
- (void)showStatusViewWithType:(SSStatusViewType)type alsoCallback:(SSStatusViewCallback)callback;
- (void)showStatusViewWithType:(SSStatusViewType)type alsoCallback:(SSStatusViewCallback)callback isDisplayCallback:(SSStatusViewTouchCallback)isDisplayCallback;

- (void)removeStatusView;

@end
