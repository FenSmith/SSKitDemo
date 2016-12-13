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

@implementation UIView (StatusAdd)
static char SSStatusViewKey;

- (void)showStatusViewWithType:(SSStatusViewType)type alsoCallback:(SSStatusViewCallback)callback {
    [self showStatusViewWithType:type alsoCallback:callback isDisplayCallback:^BOOL{
        return NO;
    }];
}

- (void)showStatusViewWithType:(SSStatusViewType)type alsoCallback:(SSStatusViewCallback)callback isDisplayCallback:(SSStatusViewTouchCallback)isDisplayCallback {
    switch (type) {
        case SSStatusViewTypeEmptyData:{
            [self showStatusViewWithImage:@"SSKIT_STATUS_EMPTYDATA" alsoDesc:@"暂无相关数据" alsoCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        case SSStatusViewTypeNetworkError:{
            [self showStatusViewWithImage:@"SSKIT_STATUS_NETWORKERROR" alsoDesc:@"网络异常请点击重试" alsoCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
        case SSStatusViewTypePortError:{
            [self showStatusViewWithImage:@"SSKIT_STATUS_SERVEERROR" alsoDesc:@"加载失败请点击重试" alsoCallback:callback isDisplayCallback:isDisplayCallback];
        }
            break;
            
        default:
            break;
    }
}

- (void)showStatusViewWithImage:(NSString *)image alsoDesc:(NSString *)desc alsoCallback:(SSStatusViewCallback)callback isDisplayCallback:(SSStatusViewTouchCallback)isDisplayCallback {
    if (!self.statusView) {
        self.statusView = [[SSStatusView alloc] init];
    }
    self.statusView.statusViewTapCallback = isDisplayCallback;
    
    self.statusView.statusViewTapHandler = callback;
    [self addSubview:self.statusView];
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.statusView resetImage:[UIImage imageNamed:image] alsoTitle:desc];
}

- (void)removeStatusView {
    if (self.statusView) {
        [self.statusView removeFromSuperview];
    }
}

- (SSStatusView *)statusView {
    return objc_getAssociatedObject(self, &SSStatusViewKey);
}

- (void)setStatusView:(SSStatusView *)statusView {
    objc_setAssociatedObject(self, &SSStatusViewKey, statusView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
