//
//  SSRefreshBaseView.h
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SSRefreshState) {
    // 初始化状态
    SSRefreshStateInitial = 0,
    // 拉动中状态
    SSRefreshStatePulling = 1,
    // 刷新状态
    SSRefreshStateRefreshing = 2,
};

#define SSPRStringify(x) #x

static inline NSString* SSPullRefreshStateString(SSRefreshState state) {
#define SSPR_CASE(x) case SSRefreshState ## x : return @SSPRStringify(SSRefreshState ## x ## Key);
    switch (state) {
            SSPR_CASE(Initial);
            SSPR_CASE(Pulling);
            SSPR_CASE(Refreshing);
    }
#undef SSPR_CASE
}

typedef void (^ SSRefreshingBlock)();

@interface SSRefreshBaseView : UIView

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic) UIEdgeInsets originalEdgeInsets;
@property (nonatomic) SSRefreshState state;

// 是否允许‘offset’与‘percent’输出 默认为'YES'
@property (nonatomic) BOOL isAllowHandleOffset;
@property (nonatomic) CGFloat offset;
@property (nonatomic) CGFloat percent;

@property (nonatomic,copy) SSRefreshingBlock refreshingBlock;

- (void)startRefreshing;
- (void)stopRefreshing;
- (void)stopRefreshingAttachDelay:(NSTimeInterval)afterDelay;

- (void)resetInsetsToOriginal:(BOOL)isToOriginal;
- (void)stateWillChangeWithType:(SSRefreshState)state;
- (void)offsetWillChangeWithValue:(CGFloat)offset withPercent:(CGFloat)percent;

@end
