//
//  UIScrollView+SSPullLoading.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPullLoadingView.h"

@interface UIScrollView (SSPullLoading)

@property (nonatomic,strong) SSPullLoadingView *pullLoadingView;

- (void)addPullLoading:(void (^)())callback;
- (void)removePullLoading;

@end
