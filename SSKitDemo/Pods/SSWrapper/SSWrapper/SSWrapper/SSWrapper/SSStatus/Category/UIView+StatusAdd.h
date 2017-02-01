//
//  UIView+StatusAdd.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSStatusBaseView.h"
#import "SSStatusNormalView.h"
#import "SSStatusLoadingView.h"
#import "SSStatusSymbolView.h"

@interface UIView (StatusAdd)

@property (nonatomic,strong) SSStatusBaseView *statusView;

- (void)viewAddStatusWithImage:(NSString *)image title:(NSString *)title forTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback;
- (void)viewAddStatusWithType:(SSStatusViewType)type forTouchCallback:(SSStatusViewTapCallback)callback;
- (void)viewAddStatusWithType:(SSStatusViewType)type forTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback;

- (void)removeStatusView;

@end
