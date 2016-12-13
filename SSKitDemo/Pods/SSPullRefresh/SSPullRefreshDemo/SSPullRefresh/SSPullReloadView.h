//
//  SSPullReloadView.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPullReloadView : UIView

typedef NS_ENUM(NSInteger , SSPullReloadState) {
    SSPullReloadStateInitial = 0,
    SSPullReloadStatePulling = 1,
    SSPullReloadStateLoading = 2,
};

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic) UIEdgeInsets originalEdgeInsets;
@property (nonatomic) SSPullReloadState pullReloadState;

@property (nonatomic,copy) NSString *initialText;
@property (nonatomic,copy) NSString *pullingText;
@property (nonatomic,copy) NSString *loadingText;

@property (nonatomic,copy) void (^ callback)();

- (void)startPullReloading;
- (void)stopPullReloading;
- (void)stopPullReloading:(NSTimeInterval)afterDelay;

@end
