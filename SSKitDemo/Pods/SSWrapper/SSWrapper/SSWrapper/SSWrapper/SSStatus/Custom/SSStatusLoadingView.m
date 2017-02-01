//
//  SSStatusLoadingView.m
//  SSStatusDemo
//
//  Created by Quincy Yan on 2017/1/27.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSStatusLoadingView.h"
#import <Masonry/Masonry.h>

@implementation SSStatusLoadingView

- (instancetype)initWithTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback {
    self = [super initWithTouchCallback:callback isDisplayCallback:isDisplayCallback];
    if (!self) return nil;
    
    [self addSubview:self.indicatorView];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.indicatorView startAnimating];
    
    return self;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _indicatorView;
}

@end
