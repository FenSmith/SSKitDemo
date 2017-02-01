//
//  SSPullingBaseView.h
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSRefreshBaseView.h"

typedef NS_ENUM(NSInteger , SSRefreshLoadingStyle) {
    // 普通类型,刷新箭头+文字提示
    SSRefreshLoadingStyleNormal = 0,
};

@interface SSLoadingBaseView : SSRefreshBaseView

@end
