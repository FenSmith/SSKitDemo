//
//  DTBClubDetailViewModel.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/11/24.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBClubDetailViewModel.h"

@implementation DTBClubDetailViewModel

- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    
    self.titleType = SSPageTitleTypeLeft;
}

- (NSString *)titleForViewModel {
    return @"社区主页";
}

@end
