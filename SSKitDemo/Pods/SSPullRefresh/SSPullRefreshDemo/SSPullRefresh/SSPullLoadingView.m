//
//  SSPullLoadingView.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSPullLoadingView.h"
#import <Masonry/Masonry.h>

static CGFloat const SSPullLoadingViewHeight = 60;

@interface SSPullLoadingView()
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation SSPullLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self addSubview:self.activityView];
    [self addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    self.initialText = @"上拉加载更多";
    self.pullingText = @"松开加载更多";
    self.loadingText = @"正在加载";
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        CGFloat offsetY = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
        CGFloat willChangeY = [self pullLoadingWillChangeY:offsetY];
        CGFloat willChangeLoading = willChangeY + SSPullLoadingViewHeight;
        
        if (self.pullLoadingState != SSPullLoadingStateLoading) {
            if (offsetY >= willChangeY && offsetY <= willChangeLoading) {
                self.pullLoadingState = SSPullLoadingStateInitial;
            }
            if (offsetY >= willChangeLoading) {
                if (!self.scrollView.isDragging) {
                    self.pullLoadingState = SSPullLoadingStateLoading;
                }else {
                    self.pullLoadingState = SSPullLoadingStatePulling;
                }
            }
        }
    }else if([keyPath isEqualToString:@"contentSize"]) {
        [self resetViewsFrame];
    }
}

- (void)resetViewsFrame {
    [self setFrame:CGRectMake(self.originalEdgeInsets.left,
                              [self pullLoadingY],
                              CGRectGetMaxX(self.scrollView.frame) - self.originalEdgeInsets.left - self.originalEdgeInsets.right,
                              SSPullLoadingViewHeight)];
}

///---------------
/// 获取自身控件的‘Y’
///---------------
- (CGFloat)pullLoadingY {
    CGFloat contentEdges = self.originalEdgeInsets.top + self.originalEdgeInsets.bottom;
    CGFloat contentSize = self.scrollView.contentSize.height;
    CGFloat tableViewSize = CGRectGetHeight(self.scrollView.frame);
    
    if (contentEdges + contentSize < tableViewSize) {
        return tableViewSize;
    }
    return contentEdges + contentSize;
}

///--------------------------------------------------------------------------------------
/// 获取刷新控件刷新的状态由’SPullLoadingStateOriginal‘改变成’SSPullLoadingStatePulling‘的临界点
///--------------------------------------------------------------------------------------
- (CGFloat)pullLoadingWillChangeY:(CGFloat)offsetY {
    CGFloat contentHeight = self.scrollView.contentSize.height;
    CGFloat tableViewHeight = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat willChangeY = contentHeight - tableViewHeight;
    if (contentHeight < tableViewHeight) {
        return tableViewHeight;
    }
    return willChangeY;
}

- (void)setPullLoadingState:(SSPullLoadingState)pullLoadingState {
    _pullLoadingState = pullLoadingState;
    
    switch (pullLoadingState) {
        case SSPullLoadingStateInitial:{
            self.textLabel.text = self.initialText;
            [self resetContentEdgeInsets:YES];
            [self.activityView stopAnimating];
        }
            break;
        case SSPullLoadingStatePulling:{
            self.textLabel.text = self.pullingText;
        }
            break;
        case SSPullLoadingStateLoading:{
            self.textLabel.text = self.loadingText;
            [self resetContentEdgeInsets:NO];
            [self.activityView startAnimating];
            if (self.callback) {
                self.callback();
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)resetContentEdgeInsets:(BOOL)isFinishLoading {
    if (isFinishLoading) {
        [self.scrollView setContentInset:self.originalEdgeInsets];
    } else {
        [self.scrollView setContentInset:UIEdgeInsetsMake(self.originalEdgeInsets.top,
                                                          self.originalEdgeInsets.left,
                                                          self.originalEdgeInsets.bottom + SSPullLoadingViewHeight,
                                                          self.originalEdgeInsets.right)];
    }
}

- (void)stopPullLoading {
    if (self.pullLoadingState != SSPullLoadingStateInitial) {
        [self stopPullLoading:1.0f];
    }
}

- (void)stopPullLoading:(NSTimeInterval)afterDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pullLoadingState = SSPullLoadingStateInitial;
    });
}

- (void)startPullLoading {
    self.pullLoadingState = SSPullLoadingStateLoading;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont fontWithName:@"Lao Sangam MN" size:14];
        _textLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:87.0/255.0 alpha:1.0f];
    }
    return _textLabel;
}

@end
