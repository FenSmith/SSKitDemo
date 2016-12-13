//
//  SSPullReloadView.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSPullReloadView.h"
#import <Masonry/Masonry.h>

static CGFloat const SSPullReloadViewHeight = 60;

@interface SSPullReloadView()
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@end

@implementation SSPullReloadView

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
    
    self.initialText = @"下拉刷新";
    self.pullingText = @"松开刷新";
    self.loadingText = @"正在刷新";
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        if (self.pullReloadState != SSPullReloadStateLoading) {
            CGFloat offsetY = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue].y;
            CGFloat willChangeY = [self pullReloadWillChangeY];
            
            if (offsetY <= 0 && offsetY >= willChangeY) {
                self.pullReloadState = SSPullReloadStateInitial;
            }else if (offsetY < willChangeY) {
                if (self.scrollView.isDragging) {
                    self.pullReloadState = SSPullReloadStatePulling;
                }else {
                    self.pullReloadState = SSPullReloadStateLoading;
                }
            }
        }
    }
}

- (CGFloat)pullReloadWillChangeY {
    return - SSPullReloadViewHeight;
}

- (void)setPullReloadState:(SSPullReloadState)pullReloadState {
    _pullReloadState = pullReloadState;
    
    switch (pullReloadState) {
        case SSPullReloadStateInitial:{
            self.textLabel.text = self.initialText;
            [self.activityView stopAnimating];
            [self resetContentEdgeInsets:YES];
        }
            break;
        case SSPullReloadStatePulling:{
            self.textLabel.text = self.pullingText;
        }
            break;
        case SSPullReloadStateLoading:{
            self.textLabel.text = self.loadingText;
            [self.activityView startAnimating];
            [self resetContentEdgeInsets:NO];
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
        [self.scrollView setContentInset:UIEdgeInsetsMake(self.originalEdgeInsets.top + SSPullReloadViewHeight,
                                                          self.originalEdgeInsets.left,
                                                          self.originalEdgeInsets.bottom,
                                                          self.originalEdgeInsets.right)];
    }
}

- (void)stopPullReloading {
    [self stopPullReloading:1.0f];
}

- (void)stopPullReloading:(NSTimeInterval)afterDelay {
    if (self.pullReloadState != SSPullReloadStateInitial) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.pullReloadState = SSPullReloadStateInitial;
        });
    }
}

- (void)startPullReloading {
    self.pullReloadState = SSPullReloadStateLoading;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:87.0/255.0 blue:87.0/255.0 alpha:1.0f];
    }
    return _textLabel;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

@end
