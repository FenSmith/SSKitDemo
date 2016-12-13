//
//  DTBPsdCell.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBPsdCell.h"

@interface DTBPsdCell()
@property (nonatomic,strong) UILabel *promptLabel;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIView *centerSpliter, *bottomSpliter;

@end

@implementation DTBPsdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.contentView addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.contentView addSubview:self.centerSpliter];
    [self.centerSpliter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.promptLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.promptLabel);
        make.height.mas_offset(0.5f);
    }];
    
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.promptLabel);
        make.height.mas_offset(40);
        make.top.equalTo(self.centerSpliter.mas_bottom).offset(5);
    }];
    
    [self.contentView addSubview:self.bottomSpliter];
    [self.bottomSpliter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.promptLabel);
        make.top.equalTo(self.textField.mas_bottom);
        make.height.mas_offset(0.5f);
    }];
    
    @weakify(self);
    [self.textField.rac_textSignal subscribeNext:^(NSString *str) {
        @strongify(self);
        if (self.callback) {
            self.callback(str);
        }
    }];
    
    RAC(self.promptLabel,text) = RACObserve(self, promptStr);
    RAC(self.textField,placeholder) = RACObserve(self, placeHolder);
    
    return self;
}

- (void)setIsPassword:(BOOL)isPassword {
    _isPassword = isPassword;
    self.textField.secureTextEntry = isPassword;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [UILabel labelAddTextColor:SSHelpColor alsoFont:14];
    }
    return _promptLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = SSNormalColor;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIView *)centerSpliter {
    if (!_centerSpliter) {
        _centerSpliter = [UIView viewAddColor:SSSpliterColor];
    }
    return _centerSpliter;
}

- (UIView *)bottomSpliter {
    if (!_bottomSpliter) {
        _bottomSpliter = [UIView viewAddColor:SSSpliterColor];
    }
    return _bottomSpliter;
}

@end
