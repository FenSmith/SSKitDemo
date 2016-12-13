//
//  SSNavigatorStacks.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/12.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSNavigatorStacks.h"
#import "SSNavigatorController.h"
#import "SSViewController.h"
#import "SSTabbarController.h"
#import "SSTabbarViewModel.h"
#import "SSPageRouter.h"

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
    
    self.service = service;
    self.navigationControllers = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)pushNavigationController:(SSNavigatorController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) {
        return;
    }
    [self.navigationControllers addObject:navigationController];
}

- (void)popNavigationController {
    if (self.navigationControllers.count > 0) {
        [self.navigationControllers removeLastObject];
    }
}

- (SSNavigatorController *)topNavigationController {
    return self.navigationControllers.lastObject;
}

- (UIWindow *)rootWindow {
    return [[UIApplication sharedApplication].windows firstObject];
}

- (void)registerNavigationHooks {
    
    @weakify(self);
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(pushViewModel:animated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         id ctr = [[SSPageRouter sharedRouter] viewControllerWithViewModel:(SSViewModel *)tuple.first];
         if (![ctr isKindOfClass:[SSNavigatorController class]]) {
             [self.navigationControllers.lastObject pushViewController:ctr animated:[tuple.second boolValue]];
         }
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(popViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         [self.navigationControllers.lastObject popViewControllerAnimated:[tuple.first boolValue]];
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(popToRootViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         [self.navigationControllers.lastObject popToRootViewControllerAnimated:[tuple.first boolValue]];
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(resetRootViewModel:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         [self.navigationControllers removeAllObjects];
         
         id viewModel = tuple.first;
         id ctr = [[SSPageRouter sharedRouter] viewControllerWithViewModel:viewModel];
         if ([ctr isKindOfClass:[SSTabbarController class]]) {
             SSNavigatorController *naviCtr = [[(SSTabbarViewModel *)viewModel viewControllers] firstObject];
             [self pushNavigationController:naviCtr];
             [self rootWindow].rootViewController = ctr;
         } else if ([ctr isKindOfClass:[SSViewController class]]) {
             SSNavigatorController *naviCtr = [[SSNavigatorController alloc] initWithRootViewController:ctr];
             [self pushNavigationController:naviCtr];
             [self rootWindow].rootViewController = naviCtr;
         } else if ([ctr isKindOfClass:[SSNavigatorController class]]) {
             [self pushNavigationController:(SSNavigatorController *)ctr];
             [self rootWindow].rootViewController = ctr;
         }
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(presentViewModel:animated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         
         id viewModel = tuple.first;
         id ctr = [[SSPageRouter sharedRouter] viewControllerWithViewModel:viewModel];
         SSNavigatorController *presentCtr = self.navigationControllers.lastObject;
         BOOL animated = [tuple.second boolValue];
         
         if ([ctr isKindOfClass:[SSTabbarController class]]) {
             SSNavigatorController *naviCtr = [[(SSTabbarViewModel *)viewModel viewControllers] firstObject];
             [self pushNavigationController:naviCtr];
             [presentCtr presentViewController:ctr animated:animated completion:tuple.third];
         } else if ([ctr isKindOfClass:[SSViewController class]]) {
             SSNavigatorController *naviCtr = [[SSNavigatorController alloc] initWithRootViewController:ctr];
             [self pushNavigationController:naviCtr];
             [presentCtr presentViewController:naviCtr animated:animated completion:tuple.third];
         } else if ([ctr isKindOfClass:[SSNavigatorController class]]) {
             [self pushNavigationController:(SSNavigatorController *)ctr];
             [presentCtr presentViewController:ctr animated:animated completion:tuple.third];
         }
     }];
    
    [[(NSObject *)self.service
      rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         [self.navigationControllers.lastObject dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
         [self popNavigationController];
     }];
}

@end
