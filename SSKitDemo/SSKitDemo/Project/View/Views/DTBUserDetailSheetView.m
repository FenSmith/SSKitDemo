//
//  DTBUserDetailSheetView.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBUserDetailSheetView.h"
#import "DTBUserDetailViewModel.h"

@interface DTBUserDetailSheetView()
@property (nonatomic,strong) UIButton *sheetButton;

@property (nonatomic,strong) DTBUserDetailViewModel *viewModel;
@end

@implementation DTBUserDetailSheetView

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
    
    return self;
}

- (void)bindViewModel {
    [super bindViewModel];

    [[self.sheetButton rac_signalForControlEvents:1<<6]
     subscribeNext:^(id x) {
         [SSAlertView showAlertViewWithTitle:@"退出登录"
                    withContent:@"你确定要退出该账号吗"
                       withOptions:@[@"确定"]
                       withCallback:^(NSInteger index) {
                           if (index == 1) {
                               [DTBUserModel clearUserData];
                               [SSPageRouter closePage];
                           }
                       }];
     }];
}

- (UIButton *)sheetButton {
    if (!_sheetButton) {
        _sheetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sheetButton setTitle:@"退 出" forState:0];
        [_sheetButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_sheetButton setBackgroundImage:UIColorFromRGBBytes(78, 133, 227).colorImage forState:0];
        [_sheetButton viewAddCornerRadius:3.0f];
    }
    return _sheetButton;
}

@end
