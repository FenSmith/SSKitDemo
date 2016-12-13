//
//  HZLoginSheetView.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBLoginSheetView.h"
#import "DTBLoginViewModel.h"

@interface DTBLoginSheetView()
@property (nonatomic,strong) UIButton *sheetButton, *registButton, *psdButton;

@property (nonatomic,strong) DTBLoginViewModel *viewModel;
@end

@implementation DTBLoginSheetView

- (instancetype)initWithViewModel:(SSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (!self) return nil;
    
    [self addSubview:self.sheetButton];
    [self.sheetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self).offset(40);
        make.height.mas_offset(45);
    }];
    
    [self addSubview:self.registButton];
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sheetButton);
        make.top.equalTo(self.sheetButton.mas_bottom).offset(10);
    }];
    
    [self addSubview:self.psdButton];
    [self.psdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.sheetButton);
        make.top.equalTo(self.registButton);
    }];
    
    return self;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [[self.sheetButton rac_signalForControlEvents:1<<6]
     subscribeNext:^(id x) {
         @strongify(self);
         [[UIApplication sharedApplication].keyWindow endEditing:YES];
         [self.viewModel.userLoginCommand execute:nil];
    }];
    
    [[self.registButton rac_signalForControlEvents:1<<6]
     subscribeNext:^(id x) {
         @strongify(self);
         [[UIApplication sharedApplication].keyWindow endEditing:YES];
         [self.viewModel.userRegistCommand execute:nil];
     }];
    
    [[self.psdButton rac_signalForControlEvents:1<<6]
     subscribeNext:^(id x) {
         @strongify(self);
         [[UIApplication sharedApplication].keyWindow endEditing:YES];
         [self.viewModel.userPsdCommand execute:nil];
     }];
    
    [self.viewModel.submitValidSignal
     subscribeNext:^(NSNumber *isValid) {
         @strongify(self);
         self.sheetButton.enabled = isValid.boolValue;
     }];
}

- (UIButton *)sheetButton {
    if (!_sheetButton) {
        _sheetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sheetButton setTitle:@"登 录" forState:0];
        [_sheetButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_sheetButton setBackgroundImage:UIColorFromRGBBytes(78, 133, 227).colorImage forState:0];
        [_sheetButton viewAddCornerRadius:3.0f];
    }
    return _sheetButton;
}

- (UIButton *)registButton {
    if (!_registButton) {
        _registButton = [UIButton buttonAddTitleColor:SSHelpColor alsoFont:13];
        [_registButton setTitle:@"注册" forState:0];
    }
    return _registButton;
}

- (UIButton *)psdButton {
    if (!_psdButton) {
        _psdButton = [UIButton buttonAddTitleColor:SSHelpColor alsoFont:13];
        [_psdButton setTitle:@"忘记密码" forState:0];
    }
    return _psdButton;
}

@end
