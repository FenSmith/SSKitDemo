//
//  SSStatusView.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSStatusNormalView.h"
#import <Masonry/Masonry.h>

@interface SSStatusNormalView()

@end

@implementation SSStatusNormalView

- (instancetype)initWithTouchCallback:(SSStatusViewTapCallback)callback isDisplayCallback:(SSStatusViewRemoveVerifyCallback)isDisplayCallback {
    self = [super initWithTouchCallback:callback isDisplayCallback:isDisplayCallback];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(20);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
    }];
    
    return self;
}

- (void)resetStatusViewWithImage:(UIImage *)image title:(NSString *)title {
    self.imageView.image = image;
    self.textLabel.text = title;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        [_textLabel setFont:[UIFont systemFontOfSize:15]];
        _textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
