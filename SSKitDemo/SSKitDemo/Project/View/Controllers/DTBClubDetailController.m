//
//  DTBClubDetailController.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/24.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBClubDetailController.h"
#import "DTBClubDetailHeader.h"
#import "DTBClubDetailViewModel.h"

@interface DTBClubDetailController ()
@property (nonatomic,strong) DTBClubDetailHeader *header;

@property (nonatomic,strong) DTBClubDetailViewModel *viewModel;
@end

@implementation DTBClubDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeaderView:self.header];
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (DTBClubDetailHeader *)header {
    if (!_header) {
        _header = [[DTBClubDetailHeader alloc] initWithViewModel:self.viewModel];
        _header.frame = CGRectMake(0, 0, kScreenW, 300);
    }
    return _header;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
