//
//  UIScrollView+Loading.m
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "UIScrollView+Loading.h"
#import <objc/runtime.h>

static CGFloat const SSPR_LOADINGVIEW_HEIGHT = 60;
static char const SSPR_LOADING_KEY;

@implementation UIScrollView (Loading)

- (void)sspr_insertLoadingViewAttachCallback:(SSRefreshingBlock)callback {
    [self sspr_insertLoadingViewAttachViewClass:[SSLoadingView class] withCallback:callback];
}

- (void)sspr_insertLoadingViewAttachViewStyle:(SSRefreshLoadingStyle)style withCallback:(SSRefreshingBlock)callback {
    [self sspr_insertLoadingViewAttachViewStyle:style withHeight:SSPR_LOADINGVIEW_HEIGHT withCallback:callback];
}

- (void)sspr_insertLoadingViewAttachViewStyle:(SSRefreshLoadingStyle)style withHeight:(CGFloat)height withCallback:(SSRefreshingBlock)callback {
    Class aClass = nil;
    switch (style) {
        case SSRefreshLoadingStyleNormal:{
            aClass = [SSLoadingView class];
        }
            break;
        default:
            break;
    }
    if (aClass) {
        [self sspr_insertLoadingViewAttachViewClass:aClass withCallback:callback];
    }
}

- (void)sspr_insertLoadingViewAttachViewClass:(Class)aClass withCallback:(SSRefreshingBlock)callback {
    [self sspr_insertLoadingViewAttachViewClass:aClass withHeight:SSPR_LOADINGVIEW_HEIGHT withCallback:callback];
}

- (void)sspr_insertLoadingViewAttachViewClass:(Class)aClass withHeight:(CGFloat)height withCallback:(SSRefreshingBlock)callback {
    if (!aClass || !callback) return;
    
    id view = [[aClass alloc] initWithFrame:CGRectZero];
    if (view && [view isKindOfClass:[SSLoadingBaseView class]]) {
        [(SSLoadingBaseView *)view setFrame:CGRectMake(0, self.contentSize.height, self.bounds.size.width, height)];
        [self sspr_insertLoadingViewAttachView:view withCallback:callback];
    }
}

- (void)sspr_insertLoadingViewAttachView:(SSLoadingBaseView *)view withCallback:(SSRefreshingBlock)callback {
    if (!view || !callback) return;
    
    [self sspr_removeLoadingView];
    
    view.frame = CGRectMake(0, self.contentSize.height, self.bounds.size.width, CGRectGetHeight(view.frame));
    view.scrollView = self;
    view.originalEdgeInsets = self.contentInset;
    view.refreshingBlock = callback;
    [self addSubview:view];
    
    self.loadingView = view;
    
    [self addObserver:self.loadingView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self.loadingView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setLoadingView:(SSLoadingBaseView *)loadingView {
    objc_setAssociatedObject(self, &SSPR_LOADING_KEY, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SSLoadingBaseView *)loadingView {
    return objc_getAssociatedObject(self, &SSPR_LOADING_KEY);
}

- (void)sspr_removeLoadingView {
    if (!self.loadingView) return;
    [self removeObserver:self.loadingView forKeyPath:@"contentOffset"];
    [self removeObserver:self.loadingView forKeyPath:@"contentSize"];
    [self.loadingView removeFromSuperview];
}

@end
