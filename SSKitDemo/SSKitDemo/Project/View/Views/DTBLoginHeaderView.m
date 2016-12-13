//
//  HZLoginHeaderView.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/27.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBLoginHeaderView.h"
#import "DTBWaveView.h"

@interface DTBLoginHeaderView ()
@property (nonatomic,strong) DTBWaveView *waveView,*waveView2;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation DTBLoginHeaderView

- (instancetype)initWithViewModel:(SSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (!self) return nil;
    
    [self viewAddBackgroundViewWithImage:[UIImage imageNamed:@"icon-login-bg"] alsoAlpha:1.0f];
    
    [self addSubview:self.waveView];
    [self.waveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_offset(50);
    }];
    
    [self addSubview:self.waveView2];
    [self.waveView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.waveView);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    return self;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    [self.waveView startWaveAnimating];
    [self.waveView2 startWaveAnimating];
}

- (DTBWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[DTBWaveView alloc] init];
    }
    return _waveView;
}

- (DTBWaveView *)waveView2 {
    if (!_waveView2) {
        _waveView2 = [[DTBWaveView alloc] init];
        _waveView2.startX = 120.0f;
        _waveView2.velocity = 2.0f;
    }
    return _waveView2;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelAddTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6f] alsoFont:20];
        _titleLabel.font = [UIFont fontWithName:@"PingFangHK-Thin" size:20];
        _titleLabel.text = @"所有的精彩 都仅在这里被发现";
    }
    return _titleLabel;
}

@end
