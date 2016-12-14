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
        return [[SSPageRouter sharedRouter] viewModelFromProtocol:[NSString stringWithFormat:@"sspage://%@",str]];
    }];
    
    SSTabbarEntity *clubObj = [[SSTabbarEntity alloc] init];
    [clubObj setImage:@"icon-club-n" alsoText:nil forControlState:0];
    [clubObj setImage:@"icon-club-s" alsoText:nil forControlState:1<<2];
    clubObj.imageSize = CGSizeMake(35, 35);
    
    SSTabbarEntity *userObj = [[SSTabbarEntity alloc] init];
    [userObj setImage:@"icon-user-n" alsoText:nil forControlState:0];
    [userObj setImage:@"icon-user-s" alsoText:nil forControlState:1<<2];
    userObj.imageSize = CGSizeMake(32, 35);
    
    self.entitys = @[clubObj,userObj];
}

@end
