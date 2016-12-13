//
//  UIScrollView+SSPullReload.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UIScrollView+SSPullReload.h"
#import <objc/runtime.h>

static CGFloat const SSPullReloadViewHeight = 60;

@implementation UIScrollView (SSPullReload)
static char SSKit_SSPullReloadView;

- (void)addPullReload:(void (^)())callback {
    if (!self.pullReloadView) {
        SSPullReloadView *view = [[SSPullReloadView alloc] initWithFrame:CGRectMake(0, - SSPullReloadViewHeight, self.bounds.size.width, SSPullReloadViewHeight)];
        view.scrollView = self;
        view.originalEdgeInsets = self.contentInset;
        view.callback = callback;
        [self addSubview:view];
        
        self.pullReloadView = view;
        
        [self addObserver:self.pullReloadView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setPullReloadView:(SSPullReloadView *)pullReloadView {
    [self willChangeValueForKey:@"SSKit_SSPullReloadView"];
    objc_setAssociatedObject(self, &SSKit_SSPullReloadView,pullReloadView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"SSKit_SSPullReloadView"];
}

- (SSPullReloadView *)pullReloadView {
    return objc_getAssociatedObject(self, &SSKit_SSPullReloadView);
}

- (void)removePullReloader {
    [self removeObserver:self.pullReloadView forKeyPath:@"contentOffset"];
    [self.pullReloadView removeFromSuperview];
}

@end
