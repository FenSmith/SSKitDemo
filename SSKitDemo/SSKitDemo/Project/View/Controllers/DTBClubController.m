//
//  DTBClubController.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/9.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBClubController.h"
#import "DTBClubViewModel.h"
#import "DTBCommunityTextCell.h"
#import "DTBCommunityImageCell.h"
#import "DTBCommunityImagesCell.h"
#import "DTBCommunityModel.h"
#import <TPKeyboardAvoidingTableView.h>


@interface DTBClubController ()

@property (nonatomic,strong) DTBClubViewModel *viewModel;
@end

@implementation DTBClubController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRGB:@"239,240,244"];
    self.tableView.frame = CGRectMake(0, 0, kScreenW, CGRectGetHeight(self.view.frame) - 44 - 64);
    
    [self.tableView registerClass:[DTBCommunityTextCell class] forCellReuseIdentifier:@"DTBCommunityTextCell"];
    [self.tableView registerClass:[DTBCommunityImageCell class] forCellReuseIdentifier:@"DTBCommunityImageCell"];
    [self.tableView registerClass:[DTBCommunityImagesCell class] forCellReuseIdentifier:@"DTBCommunityImagesCell"];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    [self.viewModel.requestRemoteDataCommand execute:@(1)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTBCommunityModel *dataSource = self.viewModel.dataSource[indexPath.row];
    if (dataSource.images.count == 0) {
        return [DTBCommunityTextCell cellHeightWithModel:dataSource];
    } else if (dataSource.images.count < 3) {
        return [DTBCommunityImageCell cellHeightWithModel:dataSource];
    } else {
        return [DTBCommunityImagesCell cellHeightWithModel:dataSource];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTBCommunityModel *dataSource = self.viewModel.dataSource[indexPath.row];
    DTBCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:[DTBCommunityCell cellIdentifierAttachDataSource:dataSource]];
    [cell bindWithDataSource:self.viewModel.dataSource[indexPath.row] forIndexPath:indexPath];
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
