//
//  HZRegistController.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/28.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBRegistController.h"
#import "DTBLoginCell.h"
#import "DTBRegistSheetView.h"
#import "DTBRegistViewModel.h"
#import <TPKeyboardAvoidingTableView.h>

@interface DTBRegistController ()
@property (nonatomic,strong) DTBRegistSheetView *sheetView;

@property (nonatomic,strong) DTBRegistViewModel *viewModel;
@end

@implementation DTBRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:self.sheetView];
    [self.tableView registerClass:[DTBLoginCell class] forCellReuseIdentifier:@"DTBLoginCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTBLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DTBLoginCell"];
    __weak typeof(self) wself = self;
    cell.textField.placeholder = @"输入手机号";
    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    cell.callback = ^(NSString *str){
        wself.viewModel.phone = str;
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (DTBRegistSheetView *)sheetView {
    if (!_sheetView) {
        _sheetView = [[DTBRegistSheetView alloc] initWithViewModel:self.viewModel];
        [_sheetView setFrame:CGRectMake(0, 0, kScreenW, 100)];
    }
    return _sheetView;
}

@end
