//
//  DTBClubDetailHeader.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/24.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBClubDetailHeader.h"
#import "DTBClubDetailViewModel.h"

@interface DTBClubDetailHeader()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) DTBClubDetailViewModel *viewModel;
@end

@implementation DTBClubDetailHeader

- (instancetype)initWithViewModel:(SSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (!self) return nil;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    return self;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    self.titleLabel.text = self.viewModel.object.title;
    self.detailLabel.text = self.viewModel.object.content;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelAddTextColor:[UIColor blackColor] alsoFont:18];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel labelAddTextColor:SSNormalColor alsoFont:15];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

@end
