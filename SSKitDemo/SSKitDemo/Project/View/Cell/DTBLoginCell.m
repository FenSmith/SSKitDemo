//
//  HZLoginCell.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBLoginCell.h"

@interface DTBLoginCell()
@property (nonatomic,strong) UIView *bottomSpliter;

@end

@implementation DTBLoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.bottom.equalTo(self.contentView);
        make.height.mas_offset(40);
    }];
    
    [self.contentView addSubview:self.bottomSpliter];
    [self.bottomSpliter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textField);
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

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = SSNormalColor;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIView *)bottomSpliter {
    if (!_bottomSpliter) {
        _bottomSpliter = [UIView viewAddColor:UIColorFromRGBBytes(230.0f, 230.0f, 230.0f)];
    }
    return _bottomSpliter;
}

@end
