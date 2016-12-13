//
//  HZRegistSheetView.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBRegistSheetView.h"
#import "DTBRegistViewModel.h"

@interface DTBRegistSheetView()
@property (nonatomic,strong) UIButton *sheetButton;

@property (nonatomic,strong) DTBRegistViewModel *viewModel;
@end

@implementation DTBRegistSheetView

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
    
    @weakify(self);
    [[self.sheetButton rac_signalForControlEvents:1<<6]
     subscribeNext:^(id x) {
         @strongify(self);
         [[UIApplication sharedApplication].keyWindow endEditing:YES];
         [self.viewModel.userRegistCommand execute:nil];
     }];
    
    [self.viewModel.phoneValidSignal
     subscribeNext:^(NSNumber *isValid) {
         self.sheetButton.enabled = isValid.boolValue;
    }];
}

- (UIButton *)sheetButton {
    if (!_sheetButton) {
        _sheetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sheetButton setTitle:@"下一步" forState:0];
        [_sheetButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_sheetButton setBackgroundImage:UIColorFromRGBBytes(78, 133, 227).colorImage forState:0];
        [_sheetButton viewAddCornerRadius:3.0f];
    }
    return _sheetButton;
}

@end
