//
//  SSRefreshBaseView.m
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSRefreshBaseView.h"

@implementation SSRefreshBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setBackgroundColor:[UIColor whiteColor]];
    _isAllowHandleOffset = YES;
    return self;
}

- (void)startRefreshing {
    self.state = SSRefreshStateRefreshing;
}

- (void)stopRefreshing {
    [self stopRefreshingAttachDelay:1.0f];
}

- (void)stopRefreshingAttachDelay:(NSTimeInterval)afterDelay {
    if (_state != SSRefreshStateInitial) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.state = SSRefreshStateInitial;
        });
    }
}

- (void)resetInsetsToOriginal:(BOOL)isToOriginal {
    
}

- (void)stateWillChangeWithType:(SSRefreshState)state {
    
}

- (void)offsetWillChangeWithValue:(CGFloat)offset withPercent:(CGFloat)percent {
    
}

- (void)setState:(SSRefreshState)state {
    if (_state == state) return;
    
    _state = state;
    [self stateWillChangeWithType:state];
    
    switch (state) {
        case SSRefreshStateInitial:{
            [UIView animateWithDuration:0.2f animations:^{
                [self resetInsetsToOriginal:YES];
            }];
        }
            break;
        case SSRefreshStatePulling:{
            
        }
            break;
        case SSRefreshStateRefreshing:{
            [self resetInsetsToOriginal:NO];
            if (self.refreshingBlock) {
                self.refreshingBlock();
            }
        }
            break;
            
        default:
            break;
    }
}

@end
