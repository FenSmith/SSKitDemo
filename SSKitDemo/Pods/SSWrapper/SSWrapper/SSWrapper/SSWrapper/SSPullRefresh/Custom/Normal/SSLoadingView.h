//
//  SSLoadingView.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSLoadingBaseView.h"

static const NSString * SSPRLOADING_TYPE_INITIAL = @"上拉加载更多";
static const NSString * SSPRLOADING_TYPE_PULLING = @"松开加载更多";
static const NSString * SSPRLOADING_TYPE_REFRESHING = @"正在加载";

@interface SSLoadingView : SSLoadingBaseView

///---------------------------
/// 修改不同状态下默认的状态显示文字
///---------------------------
- (void)resetTitleAttachText:(NSString *)text forState:(SSRefreshState)state;

@end
