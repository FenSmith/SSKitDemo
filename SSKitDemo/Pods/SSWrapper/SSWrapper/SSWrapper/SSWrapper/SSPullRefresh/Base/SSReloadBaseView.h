//
//  SSReloadBaseView.h
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSRefreshBaseView.h"

typedef NS_ENUM(NSInteger , SSRefreshReloadStyle) {
    // 普通类型,刷新箭头+文字提示
    SSRefreshReloadStyleNormal = 0,
    // 星星类型,只有Reload有
    SSRefreshReloadStyleStar = 1,
};

@interface SSReloadBaseView : SSRefreshBaseView

@end
