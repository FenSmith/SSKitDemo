//
//  SSTabbarController.m
//  SSKit
//
//  Created by Quincy Yan on 16/4/23.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTabbarController.h"
#import "SSPageRouter.h"
#import "SSTabbarViewModel.h"
#import "SSNavigatorStacks.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <SSWrapper/SSTabbar.h>

@interface SSTabbarController()<SSTabbarDelegate>
@property (nonatomic,strong) SSTabbar *tabbar;

@property (nonatomic,strong) SSTabbarViewModel *viewModel;
@end

@implementation SSTabbarController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    SSTabbarController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(initWithViewModel:)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindInitialization];
         [viewController bindNotification];
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(SSTabbarViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    self.viewModel = viewModel;
    return self;    
}

- (void)bindViewModel {
    @weakify(self);
    [RACObserve(self.viewModel, viewControllers)
     subscribeNext:^(NSArray *viewControllers) {
         @strongify(self);
         self.viewControllers = viewControllers;
     }];
    
    [RACObserve(self.viewModel, wrappers)
     subscribeNext:^(NSArray *wrappers) {
         @strongify(self);
         self.tabbar.wrappers = wrappers;
         [self.tabbar reloadAllWrappers];
    }];
    
    [self.tabBar addSubview:self.tabbar];
}

- (void)bindNotification {
    
}

- (void)bindInitialization {
    
}

- (BOOL)tabbar:(SSTabbar *)aTabbar wrapperClickedAtIndex:(NSInteger)index {
    if (![self.viewModel selectWrapperAtIndex:index]) {
        return NO;
    }
    
    self.selectedIndex = index;
    [[SSPageRouter sharedRouter].stacks popNavigationController];
    [[SSPageRouter sharedRouter].stacks pushNavigationController:self.viewModel.viewControllers[index]];
    
    return YES;
}

- (SSTabbar *)tabbar {
    if (!_tabbar) {
        _tabbar = [[SSTabbar alloc] init];
        _tabbar.backgroundColor = [UIColor whiteColor];
        _tabbar.frame = self.tabBar.bounds;
        _tabbar.delegate = self;
    }
    return _tabbar;
}

@end
