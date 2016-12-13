//
//  UIScrollView+SSPullReload.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPullReloadView.h"

@interface UIScrollView (SSPullReload)

@property (nonatomic,strong) SSPullReloadView *pullReloadView;

- (void)addPullReload:(void (^)())callback;
- (void)removePullReloader;

@end
