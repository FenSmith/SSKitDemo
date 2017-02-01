//
//  SSPullingBaseView.m
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSLoadingBaseView.h"

@implementation SSLoadingBaseView

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        if (self.state != SSRefreshStateRefreshing) {
            CGFloat offset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
            CGFloat initial2Pulling = [self initial2Pulling];
            CGFloat pulling2Refresh = [self pulling2Refreshing];
            self.offset = offset;
            
            if (offset < initial2Pulling) {
                self.state = SSRefreshStateInitial;
                self.percent = 0.0f;
            } else if (offset >= initial2Pulling && offset < pulling2Refresh) {
                self.state = SSRefreshStateInitial;
                self.percent = (offset - initial2Pulling) / CGRectGetHeight(self.frame);
            } else if (offset > pulling2Refresh) {
                self.percent = 1.0f;
                if (self.scrollView.isDragging) {
                    self.state = SSRefreshStatePulling;
                } else {
                    self.state = SSRefreshStateRefreshing;
                }
            }
            
            if (self.isAllowHandleOffset && [self respondsToSelector:@selector(offsetWillChangeWithValue:withPercent:)]) {
                [self offsetWillChangeWithValue:self.offset withPercent:self.percent];
            }
        }
    } else if([keyPath isEqualToString:@"contentSize"]) {
        [self resetViewsFrame];
    }
}

- (CGFloat)initial2Pulling {
    CGFloat scrollc = self.scrollView.contentSize.height;
    CGFloat scrollh = CGRectGetHeight(self.scrollView.frame);
    if (scrollc < scrollh) return self.originalEdgeInsets.top + self.originalEdgeInsets.bottom;
    return scrollc - scrollh;
}

- (CGFloat)pulling2Refreshing {
    return [self initial2Pulling] + CGRectGetHeight(self.frame);
}

- (void)resetViewsFrame {
    [self setFrame:CGRectMake(self.originalEdgeInsets.left,
                              [self viewFrameOriginY],
                              CGRectGetWidth(self.scrollView.frame) - self.originalEdgeInsets.left - self.originalEdgeInsets.right,
                              CGRectGetHeight(self.frame))];
}

- (CGFloat)viewFrameOriginY {
    CGFloat scrolly = self.originalEdgeInsets.top + self.originalEdgeInsets.bottom + self.scrollView.contentSize.height;
    CGFloat scrollh = CGRectGetHeight(self.scrollView.frame);
    if (scrolly < scrollh) return scrollh;
    return scrolly;
}

- (void)resetInsetsToOriginal:(BOOL)isToOriginal {
    if (isToOriginal) {
        [self.scrollView setContentInset:self.originalEdgeInsets];
    } else {
        [self.scrollView setContentInset:UIEdgeInsetsMake(self.originalEdgeInsets.top,
                                                          self.originalEdgeInsets.left,
                                                          self.originalEdgeInsets.bottom + CGRectGetHeight(self.frame),
                                                          self.originalEdgeInsets.right)];
    }
}

@end
