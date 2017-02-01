//
//  SSReloadView.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSReloadBaseView.h"

static const NSString * SSPRRELOAD_TYPE_INITIAL = @"下拉刷新";
static const NSString * SSPRRELOAD_TYPE_PULLING = @"松开刷新";
static const NSString * SSPRRELOAD_TYPE_REFRESHING = @"正在刷新";

@interface SSReloadView : SSReloadBaseView

///---------------------------
/// 修改不同状态下默认的状态显示文字
///---------------------------
- (void)resetTitleAttachText:(NSString *)text forState:(SSRefreshState)state;

@end
