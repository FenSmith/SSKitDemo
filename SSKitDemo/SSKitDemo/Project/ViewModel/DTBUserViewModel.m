//
//  DTBUserViewModel.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/9.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBUserViewModel.h"
#import "DTBUserPageModel.h"

@implementation DTBUserViewModel

- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    
    NSArray *source = @[@{@"icon":@"icon-user-history",@"name":@"观看记录",@"color":UIColorFromRGBBytes(43, 163, 230)},
                        @{@"icon":@"icon-user-store",@"name":@"我的收藏",@"color":UIColorFromRGBBytes(232, 186, 74)},
                        @{@"icon":@"icon-user-community",@"name":@"我的社区",@"color":UIColorFromRGBBytes(228, 83, 75)}];
    
    self.dataSource = [source objsMap:^id(NSDictionary *object, NSInteger index) {
        DTBUserPageModel *model = [[DTBUserPageModel alloc] init];
        model.icon = [[UIImage imageNamed:object[@"icon"]] imageScale:3.5f];
        model.property = object[@"name"];
        model.iconColor = object[@"color"];
        return model;
    }];
}

- (NSString *)titleForViewModel {
    return @"个人中心";
}

- (SSPageTitleType)titleType {
    return SSPageTitleTypeLeftOnlyTitle;
}

@end
