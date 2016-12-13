//
//  UIScrollView+SSPullLoading.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UIScrollView+SSPullLoading.h"
#import <objc/runtime.h>

static CGFloat const SSPullLoadingViewHeight = 60;

@implementation UIScrollView (SSPullLoading)
static char SSKit_SSPullLoadingView;

- (void)addPullLoading:(void (^)())callback {
    if (!self.pullLoadingView) {
        SSPullLoadingView *view = [[SSPullLoadingView alloc] initWithFrame:CGRectMake(0, self.contentSize.height, self.bounds.size.width, SSPullLoadingViewHeight)];
        view.scrollView = self;
        view.originalEdgeInsets = self.contentInset;
        view.callback = callback;
        [self addSubview:view];
        
        self.pullLoadingView = view;
        
        [self addObserver:self.pullLoadingView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self.pullLoadingView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setPullLoadingView:(SSPullLoadingView *)pullLoadingView {
    [self willChangeValueForKey:@"SSKit_SSPullLoadingView"];
    objc_setAssociatedObject(self, &SSKit_SSPullLoadingView,pullLoadingView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"SSKit_SSPullLoadingView"];
}

- (SSPullLoadingView *)pullLoadingView {
    return objc_getAssociatedObject(self, &SSKit_SSPullLoadingView);
}

- (void)removePullLoading {
    [self removeObserver:self.pullLoadingView forKeyPath:@"contentOffset"];
    [self removeObserver:self.pullLoadingView forKeyPath:@"contentSize"];
    [self.pullLoadingView removeFromSuperview];
}

@end
