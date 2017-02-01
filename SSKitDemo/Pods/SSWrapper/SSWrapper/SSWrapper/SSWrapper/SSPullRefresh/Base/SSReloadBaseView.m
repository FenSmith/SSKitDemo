//
//  SSReloadBaseView.m
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSReloadBaseView.h"

@implementation SSReloadBaseView

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        if (self.state != SSRefreshStateRefreshing) {
            CGFloat offset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
            CGFloat pulling2Refresh = [self distanceFromPulling2Refreshing];
            CGFloat initial2Pulling = [self distanceFromInitial2Pulling];
            self.offset = offset;
            
            if (offset >= initial2Pulling) {
                self.state = SSRefreshStateInitial;
                self.percent = 0.0f;
            } else if ((offset < initial2Pulling && offset >= pulling2Refresh && self.scrollView.isDragging) || (offset < pulling2Refresh && self.scrollView.isDragging)) {
                self.state = SSRefreshStatePulling;
                self.percent = [self calculatePercentWhenPullingAttachOffset:offset];;
            } else if (offset < pulling2Refresh && !self.scrollView.isDragging) {
                self.state = SSRefreshStateRefreshing;
                self.percent = 1.0f;
            }
            
            if (self.isAllowHandleOffset && [self respondsToSelector:@selector(offsetWillChangeWithValue:withPercent:)]) {
                [self offsetWillChangeWithValue:self.offset withPercent:self.percent];
            }
        }
    }
}

- (CGFloat)calculatePercentWhenPullingAttachOffset:(CGFloat)offset {
    CGFloat rOffset = offset - [self distanceFromInitial2Pulling];
    CGFloat pOffset = fabs(rOffset);
    CGFloat percent = pOffset / CGRectGetHeight(self.frame);
    if (percent > 1.0) return 1.0f;
    return percent;
}

- (CGFloat)distanceFromInitial2Pulling {
    return - self.originalEdgeInsets.top;
}

- (CGFloat)distanceFromPulling2Refreshing {
    return - self.originalEdgeInsets.top - CGRectGetHeight(self.frame);
}

- (void)resetInsetsToOriginal:(BOOL)isToOriginal {
    if (isToOriginal) {
        [self.scrollView setContentInset:self.originalEdgeInsets];
    } else {
        [self.scrollView setContentInset:UIEdgeInsetsMake(self.originalEdgeInsets.top + CGRectGetHeight(self.frame),
                                                          self.originalEdgeInsets.left,
                                                          self.originalEdgeInsets.bottom,
                                                          self.originalEdgeInsets.right)];
    }
}

@end
