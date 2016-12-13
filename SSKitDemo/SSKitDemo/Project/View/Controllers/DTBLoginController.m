//
//  HZLoginController.m
//  HZHouse-iOS
//
//  Created by QuincyYan on 16/9/27.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBLoginController.h"
#import "DTBLoginHeaderView.h"
#import "DTBLoginViewModel.h"
#import "DTBLoginCell.h"
#import "DTBLoginSheetView.h"

@interface DTBLoginController ()
@property (nonatomic,strong) DTBLoginHeaderView *headerView;
@property (nonatomic,strong) DTBLoginSheetView *sheetView;

@property (nonatomic,strong) DTBLoginViewModel *viewModel;
@end

@implementation DTBLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self clearNavigationBar];
    
    [self.tableView setFrame:CGRectMake(0, -64, kScreenW, kScreenH)];
    [self.tableView setTableHeaderView:self.headerView];
    [self.tableView setTableFooterView:self.sheetView];
    
    [self.tableView registerClass:[DTBLoginCell class] forCellReuseIdentifier:@"DTBLoginCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTBLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DTBLoginCell"];
    cell.textField.secureTextEntry = indexPath.row == 1;
    
    @weakify(self);
    switch (indexPath.row) {
        case 0:{
            cell.textField.placeholder = @"手机号/邮箱/用户名";
            cell.callback = ^(NSString *str){
                @strongify(self);
                self.viewModel.username = str;
            };
        }
            break;
        case 1:{
            cell.textField.placeholder = @"密码";
            cell.callback = ^(NSString *str){
                @strongify(self);
                self.viewModel.password = str;
            };
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 90 : 65;
}

- (DTBLoginHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[DTBLoginHeaderView alloc] initWithViewModel:self.viewModel];
        [_headerView setFrame:CGRectMake(0, 0, kScreenW, 220)];
    }
    return _headerView;
}

- (DTBLoginSheetView *)sheetView {
    if (!_sheetView) {
        _sheetView = [[DTBLoginSheetView alloc] initWithViewModel:self.viewModel];
        [_sheetView setFrame:CGRectMake(0, 0, kScreenW, 150)];
    }
    return _sheetView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

@end
