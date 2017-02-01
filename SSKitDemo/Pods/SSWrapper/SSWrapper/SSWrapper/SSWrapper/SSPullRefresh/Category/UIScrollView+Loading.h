//
//  UIScrollView+Loading.h
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLoadingView.h"
#import "SSLoadingBaseView.h"

@interface UIScrollView (Loading)

@property (nonatomic,strong) SSLoadingBaseView *loadingView;

/**
 添加默认的刷新控件
 */
- (void)sspr_insertLoadingViewAttachCallback:(SSRefreshingBlock)callback;

/**
 添加自定义的刷新控件
 view需指定size
 */
- (void)sspr_insertLoadingViewAttachView:(SSLoadingBaseView *)view withCallback:(SSRefreshingBlock)callback;
- (void)sspr_insertLoadingViewAttachViewStyle:(SSRefreshLoadingStyle)style withCallback:(SSRefreshingBlock)callback;
- (void)sspr_insertLoadingViewAttachViewStyle:(SSRefreshLoadingStyle)style withHeight:(CGFloat)height withCallback:(SSRefreshingBlock)callback;
- (void)sspr_insertLoadingViewAttachViewClass:(Class)aClass withCallback:(SSRefreshingBlock)callback;
- (void)sspr_insertLoadingViewAttachViewClass:(Class)aClass withHeight:(CGFloat)height withCallback:(SSRefreshingBlock)callback;

- (void)sspr_removeLoadingView;

@end
