//
//  UIScrollView+Reload.m
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "UIScrollView+Reload.h"
#import <objc/runtime.h>

static CGFloat const SSPR_RELOADVIEW_HEIGHT = 60;
static char const SSPR_RELOAD_KEY;

@implementation UIScrollView (Reload)

- (void)sspr_insertReloadViewAttachCallback:(SSRefreshingBlock)callback {
    [self sspr_insertReloadViewAttachViewClass:[SSReloadView class] withCallback:callback];
}

- (void)sspr_insertReloadViewAttachViewStyle:(SSRefreshReloadStyle)style withCallback:(SSRefreshingBlock)callback {
    [self sspr_insertReloadViewAttachViewStyle:style withHeight:SSPR_RELOADVIEW_HEIGHT withCallback:callback];
}

- (void)sspr_insertReloadViewAttachViewStyle:(SSRefreshReloadStyle)style withHeight:(CGFloat)height withCallback:(SSRefreshingBlock)callback {
    Class aClass = nil;
    switch (style) {
        case SSRefreshReloadStyleNormal:{
            aClass = [SSReloadView class];
        }
            break;
        case SSRefreshReloadStyleStar:{
            aClass = [SSStarReloadView class];
        }
            break;
        default:
            break;
    }
    if (aClass) {
        [self sspr_insertReloadViewAttachViewClass:aClass withHeight:height withCallback:callback];
    }
}

- (void)sspr_insertReloadViewAttachViewClass:(Class)aClass withCallback:(SSRefreshingBlock)callback {
    [self sspr_insertReloadViewAttachViewClass:aClass withHeight:SSPR_RELOADVIEW_HEIGHT withCallback:callback];
}

- (void)sspr_insertReloadViewAttachViewClass:(Class)aClass withHeight:(CGFloat)height withCallback:(SSRefreshingBlock)callback {
    if (!aClass || !callback) return;
    
    id view = [[aClass alloc] initWithFrame:CGRectZero];
    if (view && [view isKindOfClass:[SSReloadBaseView class]]) {
        [(SSReloadBaseView *)view setFrame:CGRectMake(0, 0, self.bounds.size.width, height)];
        [self sspr_insertReloadViewAttachView:view withCallback:callback];
    }
}

- (void)sspr_insertReloadViewAttachView:(SSReloadBaseView *)view withCallback:(SSRefreshingBlock)callback {
    if (!view || !callback) return;
    
    [self sspr_removeReloadView];
    
    view.frame = CGRectMake(0, -CGRectGetHeight(view.frame) - self.contentInset.top, self.bounds.size.width, CGRectGetHeight(view.frame));
    view.scrollView = self;
    view.originalEdgeInsets = self.contentInset;
    view.refreshingBlock = callback;
    [self addSubview:view];
    
    self.reloadView = view;
    
    [self addObserver:self.reloadView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setReloadView:(SSReloadBaseView *)reloadView {
    objc_setAssociatedObject(self, &SSPR_RELOAD_KEY, reloadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SSReloadBaseView *)reloadView {
    return objc_getAssociatedObject(self, &SSPR_RELOAD_KEY);
}

- (void)sspr_removeReloadView {
    if (!self.reloadView) return;
    [self removeObserver:self.reloadView forKeyPath:@"contentOffset"];
    [self.reloadView removeFromSuperview];
}

@end
