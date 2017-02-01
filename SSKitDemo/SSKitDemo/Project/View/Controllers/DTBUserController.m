//
//  DTBUserController.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/9.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBUserController.h"
#import "DTBUserHeaderView.h"
#import "DTBUserViewModel.h"
#import "DTBUserPageCell.h"
#import <TPKeyboardAvoidingTableView.h>

@interface DTBUserController ()
@property (nonatomic,strong) DTBUserHeaderView *headerView;

@property (nonatomic,strong) DTBUserViewModel *viewModel;
@end

@implementation DTBUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = UIColorFromRGBBytes(245.0, 245.0, 245.0f);
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerClass:[DTBUserPageCell class] forCellReuseIdentifier:@"DTBUserPageCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTBUserPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DTBUserPageCell"];
    [cell bindWithViewModel:self.viewModel fetchDataSource:self.viewModel.dataSource[indexPath.row] forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (DTBUserHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[DTBUserHeaderView alloc] initWithViewModel:self.viewModel];
        [_headerView setFrame:CGRectMake(0, 0, kScreenW, 100)];
    }
    return _headerView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
