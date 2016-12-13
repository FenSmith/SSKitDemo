//
//  SSPullLoadingView.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPullLoadingView : UIView

typedef NS_ENUM(NSInteger , SSPullLoadingState) {
    SSPullLoadingStateInitial = 0,
    SSPullLoadingStatePulling = 1,
    SSPullLoadingStateLoading = 2,
};

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic) UIEdgeInsets originalEdgeInsets;
@property (nonatomic) SSPullLoadingState pullLoadingState;

@property (nonatomic,copy) NSString *initialText;
@property (nonatomic,copy) NSString *pullingText;
@property (nonatomic,copy) NSString *loadingText;

@property (nonatomic,copy) void (^ callback)();

- (void)startPullLoading;
- (void)stopPullLoading;
- (void)stopPullLoading:(NSTimeInterval)afterDelay;

@end
