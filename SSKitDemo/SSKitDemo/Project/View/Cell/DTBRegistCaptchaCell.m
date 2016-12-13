//
//  HZRegistCaptchaCell.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBRegistCaptchaCell.h"
#import "DTBCaptchaViewModel.h"

@interface DTBRegistCaptchaCell()
@property (nonatomic,strong) UIView *bottomSpliter;
@property (nonatomic,strong) UIButton *resendButton;
@end

@implementation DTBRegistCaptchaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-90);
        make.bottom.equalTo(self.contentView);
        make.height.mas_offset(40);
    }];
    
    [self.contentView addSubview:self.resendButton];
    [self.resendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    
    [self.contentView addSubview:self.bottomSpliter];
    [self.bottomSpliter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.bottom.equalTo(self.contentView);
        make.height.mas_offset(0.5f);
    }];
    
    @weakify(self);
    [self.textField.rac_textSignal
     subscribeNext:^(NSString *str) {
        @strongify(self);
        if (self.callback) {
            self.callback(str);
        }
    }];
    
    return self;
}

- (void)bindWithViewModel:(DTBCaptchaViewModel *)viewModel indexPath:(NSIndexPath *)indexPath {
    
    @weakify(self);
    [[[[[[self.resendButton rac_signalForControlEvents:1<<6]
     map:^id(id value) {
         return [viewModel retryButtonTitleAndEnable];
     }] startWith:[viewModel retryButtonTitleAndEnable]]
       switchToLatest]
      takeUntil:[self rac_prepareForReuseSignal]]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         NSString *title = tuple.first;
         [self.resendButton setTitle:title forState:0];
         self.resendButton.enabled = ((NSNumber *)tuple.second).boolValue;
     }];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = SSNormalColor;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}

- (UIView *)bottomSpliter {
    if (!_bottomSpliter) {
        _bottomSpliter = [UIView viewAddColor:UIColorFromRGBBytes(230.0f, 230.0f, 230.0f)];
    }
    return _bottomSpliter;
}

- (UIButton *)resendButton {
    if (!_resendButton) {
        _resendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resendButton setTitleColor:SSHelpColor forState:0];
        [_resendButton setTitleColor:SSSpliterColor forState:1<<1];
        [_resendButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_resendButton setTitle:@"获取验证码" forState:0];
    }
    return _resendButton;
}

@end
