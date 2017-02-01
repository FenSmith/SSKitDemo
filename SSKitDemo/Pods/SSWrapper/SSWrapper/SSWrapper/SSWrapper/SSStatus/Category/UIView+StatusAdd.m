//
//  UIView+StatusAdd.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UIView+StatusAdd.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static char const SSSTATUSVIEW_KEY;

@implementation UIView (StatusAdd)

- (void)viewAddStatusWithType:(SSStatusViewType)type forTouchCallback:(SSStatusViewTapCallback)callback {
    [self viewAddStatusWithType:type forTouchCallback:callback isDisplayCallback:^BOOL{
        return NO;
    }];
}

- (void)viewAddStatusWithType:(SSStatusViewType)type forTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback {
    switch (type) {
        case SSStatusViewTypeEmptyData: {
            [self viewAddStatusWithImage:@"SSKIT_STATUS_EMPTYDATA" title:@"暂无相关数据" forTouchCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        case SSStatusViewTypeNetworkError: {
            [self viewAddStatusWithImage:@"SSKIT_STATUS_NETWORKERROR" title:@"网络异常请点击重试" forTouchCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        case SSStatusViewTypePortError: {
            [self viewAddStatusWithImage:@"SSKIT_STATUS_SERVEERROR" title:@"加载失败请点击重试" forTouchCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        case SSStatusViewTypeLoading: {
            [self viewAddLoadingForTouchCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        case SSStatusViewTypeSymbolSuccess: {
            [self viewAddSymbolViewWithType:SSStatusViewTypeSymbolSuccess withTouchCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        case SSStatusViewTypeSymbolAlert: {
            [self viewAddSymbolViewWithType:SSStatusViewTypeSymbolAlert withTouchCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        case SSStatusViewTypeSymbolError: {
            [self viewAddSymbolViewWithType:SSStatusViewTypeSymbolError withTouchCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        default:
            break;
    }
}

- (void)viewAddStatusWithImage:(NSString *)image title:(NSString *)title forTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback {
    [self removeStatusView];
    
    SSStatusNormalView *view = [[SSStatusNormalView alloc] initWithTouchCallback:callback isDisplayCallback:isDisplayCallback];
    [view resetStatusViewWithImage:[UIImage imageNamed:image] title:title];
    [self resetViewToLocalAttachView:view];
}

- (void)viewAddLoadingForTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback {
    [self removeStatusView];
    
    SSStatusLoadingView *view = [[SSStatusLoadingView alloc] initWithTouchCallback:callback isDisplayCallback:isDisplayCallback];
    [self resetViewToLocalAttachView:view];
}

- (void)viewAddSymbolViewWithType:(SSStatusViewType)type withTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback {
    [self removeStatusView];
    
    SSStatusSymbolView *view = [[SSStatusSymbolView alloc] initWithTouchCallback:callback isDisplayCallback:isDisplayCallback];
    view.type = type;
    [view statusSymbolViewReadyToAnimation];
    [self resetViewToLocalAttachView:view];
}

- (void)resetViewToLocalAttachView:(SSStatusBaseView *)view {
    self.statusView = view;
    
    [self addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)removeStatusView {
    if (self.statusView) {
        [self.statusView removeFromSuperview];
        objc_removeAssociatedObjects(self.statusView);
    }
}

- (SSStatusBaseView *)statusView {
    return objc_getAssociatedObject(self, &SSSTATUSVIEW_KEY);
}

- (void)setStatusView:(SSStatusBaseView *)statusView {
    objc_setAssociatedObject(self, &SSSTATUSVIEW_KEY, statusView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
