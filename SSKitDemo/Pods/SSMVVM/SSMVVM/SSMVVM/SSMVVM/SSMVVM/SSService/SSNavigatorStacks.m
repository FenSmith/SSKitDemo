//
//  SSNavigatorStacks.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/12.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSNavigatorStacks.h"
#import "SSViewController.h"
#import "SSTabbarController.h"
#import "SSTabbarViewModel.h"
#import "SSPageRouter.h"
#import "SSViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface SSNavigatorStacks()
@property (nonatomic,strong) id<SSViewModelService> service;
@property (nonatomic,strong) NSMutableArray *navigationControllers;

@end

@implementation SSNavigatorStacks

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    SSNavigatorStacks *navigationControllerStack = [super allocWithZone:zone];
    
    @weakify(navigationControllerStack)
    [[navigationControllerStack
      rac_signalForSelector:@selector(initWithService:)]
    	subscribeNext:^(id x) {
            @strongify(navigationControllerStack)
            [navigationControllerStack registerNavigationHooks];
        }];
    
    return navigationControllerStack;
}

- (instancetype)initWithService:(id<SSViewModelService>)service {
    self = [super init];
    if (!self) return nil;
    
    _service = service;
    _navigationControllers = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)pushNavigationController:(SSNavigatorController *)navigationController {
    if ([_navigationControllers containsObject:navigationController]) {
        return;
    }
    [_navigationControllers addObject:navigationController];
}

- (void)popNavigationController {
    if (_navigationControllers.count > 0) {
        [_navigationControllers removeLastObject];
    }
}

- (SSNavigatorController *)topNavigationController {
    return _navigationControllers.lastObject;
}

- (UIWindow *)rootWindow {
    return [[UIApplication sharedApplication].windows firstObject];
}

- (void)registerNavigationHooks {
    
    @weakify(self);
    [[(NSObject *)self.service rac_signalForSelector:@selector(pushViewModel:animated:)]
    subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        id vc = [[SSPageRouter sharedRouter] viewControllerForViewModel:tuple.first fetchControllerParams:nil];
        BOOL isAnimated = [tuple.second boolValue];
        if (![vc isKindOfClass:[SSNavigatorController class]]) {
            [[self topNavigationController] pushViewController:vc animated:isAnimated];
        }
     }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(popViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         BOOL isAnimated = [tuple.first boolValue];
         [[self topNavigationController] popViewControllerAnimated:isAnimated];
     }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(popToRootViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         BOOL isAnimated = [tuple.first boolValue];
         [[self topNavigationController] popToRootViewControllerAnimated:isAnimated];
     }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(resetRootViewModel:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         [self.navigationControllers removeAllObjects];
         
         id vm = tuple.first;
         id vc = [[SSPageRouter sharedRouter] viewControllerForViewModel:vm fetchControllerParams:nil];
         SSPageType type = [self typeForViewController:vc];
         SSNavigatorController *nvc = nil;
         
         switch (type) {
             case SSPageTypeUnknow:{
                 
             }
                 break;
             case SSPageTypeViewController:{
                 nvc = [[SSNavigatorController alloc] initWithRootViewController:vc];
             }
                 break;
             case SSPageTypeNaviController:{
                 nvc = vc;
             }
                 break;
             case SSPageTypeTabbarController:{
                 SSTabbarViewModel *tvm = vm;
                 nvc = tvm.viewControllers.firstObject;
             }
                 break;
             default:
                 break;
         }
         
         if (nvc == nil) {
             nvc = [[SSPageRouter sharedRouter] defaultNavigationController];
         }
         
         [self pushNavigationController:nvc];
         
         if (type == SSPageTypeTabbarController) {
             [self rootWindow].rootViewController = vc;
         } else {
             [self rootWindow].rootViewController = nvc;
         }
     }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(presentViewModel:animated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         id vm = tuple.first;
         id vc = [[SSPageRouter sharedRouter] viewControllerForViewModel:vm fetchControllerParams:nil];
         SSPageType type = [self typeForViewController:vc];
         BOOL isAnimated = [tuple.second boolValue];
         ssVoidBlock block = [tuple.third copy];
         
         switch (type) {
             case SSPageTypeViewController:{
                 SSNavigatorController *nvc = [[SSNavigatorController alloc] initWithRootViewController:vc];
                 [self pushNavigationController:nvc];
                 [[self topNavigationController] presentViewController:nvc animated:isAnimated completion:block];
             }
                 break;
             case SSPageTypeTabbarController:{
                 SSTabbarViewModel *tvm = vm;
                 SSNavigatorController *nvc = tvm.viewControllers.firstObject;
                 [self pushNavigationController:nvc];
                 [[self topNavigationController] presentViewController:nvc animated:isAnimated completion:block];
             }
                 break;
             default:
                 break;
         }
     }];
    
    [[(NSObject *)self.service rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         BOOL isAnimated = [tuple.second boolValue];
         ssVoidBlock block = [tuple.third copy];
         
         [[self topNavigationController] dismissViewControllerAnimated:isAnimated completion:block];
         [self popNavigationController];
     }];
}

- (SSPageType)typeForViewController:(id)viewController {
    if ([viewController isKindOfClass:[SSTabbarController class]]) {
        return SSPageTypeTabbarController;
    } else if ([viewController isKindOfClass:[SSNavigatorController class]]) {
        return SSPageTypeNaviController;
    } else if ([viewController isKindOfClass:[SSViewController class]]) {
        return SSPageTypeViewController;
    }
    return SSPageTypeUnknow;
}

@end
