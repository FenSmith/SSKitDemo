//
//  DTBUserDetailController.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/11.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBUserDetailController.h"
#import "DTBUserDetailViewModel.h"
#import "DTBUserDetailSheetView.h"

@interface DTBUserDetailController ()
@property (nonatomic,strong) DTBUserDetailSheetView *sheetView;

@property (nonatomic,strong) DTBUserDetailViewModel *viewModel;
@end

@implementation DTBUserDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSheetView:self.sheetView];
}

- (DTBUserDetailSheetView *)sheetView {
    if (!_sheetView) {
        _sheetView = [[DTBUserDetailSheetView alloc] initWithViewModel:self.viewModel];
        _sheetView.frame = CGRectMake(0, 0, kScreenW, 100);
    }
    return _sheetView;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

@end
