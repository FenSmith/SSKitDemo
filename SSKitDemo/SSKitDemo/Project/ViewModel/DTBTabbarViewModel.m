//
//  DTBTabbarViewModel.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/9.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "DTBTabbarViewModel.h"

@implementation DTBTabbarViewModel

- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    
    NSArray *viewModels = @[@"DTBClubViewModel",@"DTBUserViewModel"];
    self.viewModels = [viewModels objsMap:^id(NSString *str, NSInteger index) {
        return [[SSPageRouter sharedRouter] viewModelForProtocol:[NSString stringWithFormat:@"sspr://%@",str] fetchParams:nil];
    }];
    
    SSTabbarWrapper *clubObj = [[SSTabbarWrapper alloc] init];
    [clubObj setWrapperImage:@"icon-club-n" withText:nil forControlState:0];
    [clubObj setWrapperImage:@"icon-club-s" withText:nil forControlState:1<<2];
    clubObj.wrapperImageSize = CGSizeMake(35, 35);
    
    SSTabbarWrapper *userObj = [[SSTabbarWrapper alloc] init];
    [userObj setWrapperImage:@"icon-user-n" withText:nil forControlState:0];
    [userObj setWrapperImage:@"icon-user-s" withText:nil forControlState:1<<2];
    userObj.wrapperImageSize = CGSizeMake(32, 35);
    
    self.wrappers = @[clubObj,userObj];
}

@end
