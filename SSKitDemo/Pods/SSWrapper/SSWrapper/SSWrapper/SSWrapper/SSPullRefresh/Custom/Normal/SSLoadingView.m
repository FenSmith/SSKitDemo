//
//  SSLoadingView.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/4.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSLoadingView.h"
#import <Masonry/Masonry.h>

@interface SSLoadingView()
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) NSMutableDictionary *stateKeys;

@end

@implementation SSLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self _refreshInitialize];
    
    return self;
}

- (void)resetTitleAttachText:(NSString *)text forState:(SSRefreshState)state {
    if (!text) return;
    [_stateKeys setValue:text forKey:SSPullRefreshStateString(state)];
}

- (void)_refreshInitialize {
    self.isAllowHandleOffset = NO;
    _stateKeys = [[NSMutableDictionary alloc] initWithDictionary:@{SSPullRefreshStateString(SSRefreshStateInitial) : SSPRLOADING_TYPE_INITIAL,
                                                                   SSPullRefreshStateString(SSRefreshStatePulling) : SSPRLOADING_TYPE_PULLING,
                                                                   SSPullRefreshStateString(SSRefreshStateRefreshing) : SSPRLOADING_TYPE_REFRESHING}];
    
}

- (void)stateWillChangeWithType:(SSRefreshState)state {
    _textLabel.text = [self keyTitleAttachState:state];
    switch (state) {
        case SSRefreshStateInitial:{
            [_activityView stopAnimating];
        }
            break;
        case SSRefreshStatePulling:{
        }
            break;
        case SSRefreshStateRefreshing:{
            [_activityView startAnimating];
        }
            break;
            
        default:
            break;
    }
}

- (NSString *)keyTitleAttachState:(SSRefreshState)state {
    NSString *key = SSPullRefreshStateString(state);
    if ([_stateKeys.allKeys containsObject:key]) {
        return [_stateKeys objectForKey:key];
    }
    return @"";
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
