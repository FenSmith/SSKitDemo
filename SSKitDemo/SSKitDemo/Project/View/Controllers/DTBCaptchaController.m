//
//  HZCaptchaController.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBCaptchaController.h"
#import "DTBCaptchaViewModel.h"
#import "DTBRegistCaptchaCell.h"
#import "DTBCaptchaSheetView.h"
#import <TPKeyboardAvoidingTableView.h>

@interface DTBCaptchaController ()
@property (nonatomic,strong) DTBCaptchaSheetView *sheetView;

@property (nonatomic,strong) DTBCaptchaViewModel *viewModel;
@end

@implementation DTBCaptchaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:self.sheetView];
    [self.tableView registerClass:[DTBRegistCaptchaCell class] forCellReuseIdentifier:@"DTBRegistCaptchaCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTBRegistCaptchaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DTBRegistCaptchaCell"];
    
    @weakify(self);
    [cell bindWithViewModel:self.viewModel forIndexPath:indexPath];
    cell.textField.placeholder = @"验证码";
    cell.callback = ^(NSString *str){
        @strongify(self);
        self.viewModel.captcha = str;
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (DTBCaptchaSheetView *)sheetView {
    if (!_sheetView) {
        _sheetView = [[DTBCaptchaSheetView alloc] initWithViewModel:self.viewModel];
        [_sheetView setFrame:CGRectMake(0, 0, kScreenW, 100)];
    }
    return _sheetView;
}

@end
