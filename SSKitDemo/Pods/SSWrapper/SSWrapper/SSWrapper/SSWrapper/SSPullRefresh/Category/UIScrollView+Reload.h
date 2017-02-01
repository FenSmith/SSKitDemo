//
//  UIScrollView+Reload.h
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSReloadView.h"
#import "SSReloadBaseView.h"
#import "SSStarReloadView.h"

@interface UIScrollView (Reload)

@property (nonatomic,strong) SSReloadBaseView *reloadView;

/**
 添加默认的刷新控件
 */
- (void)sspr_insertReloadViewAttachCallback:(SSRefreshingBlock)callback;

/**
 添加自定义的刷新控件
 view需指定size
 */
- (void)sspr_insertReloadViewAttachView:(SSReloadBaseView *)view withCallback:(SSRefreshingBlock)callback;
- (void)sspr_insertReloadViewAttachViewStyle:(SSRefreshReloadStyle)style withCallback:(SSRefreshingBlock)callback;
- (void)sspr_insertReloadViewAttachViewStyle:(SSRefreshReloadStyle)style withHeight:(CGFloat)height withCallback:(SSRefreshingBlock)callback;
- (void)sspr_insertReloadViewAttachViewClass:(Class)aClass withCallback:(SSRefreshingBlock)callback;
- (void)sspr_insertReloadViewAttachViewClass:(Class)aClass withHeight:(CGFloat)height withCallback:(SSRefreshingBlock)callback;

- (void)sspr_removeReloadView;

@end
