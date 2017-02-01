//
//  SSTabbarViewModel.m
//  SSKit
//
//  Created by Quincy Yan on 16/3/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTabbarViewModel.h"
#import "SSPageRouter.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <SSKitUtility/NSArray+SSKit.h>
#import <SSKitUtility/NSObject+Property.h>

@interface SSTabbarViewModel()

@end

@implementation SSTabbarViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    SSTabbarViewModel *viewModel = [super allocWithZone:zone];
    
    @weakify(viewModel);
    RACSignal *initialParamsSignal = [viewModel rac_signalForSelector:@selector(initWithService:fetchParams:)];
    [[RACSignal merge:@[initialParamsSignal]]
     subscribeNext:^(id x) {
         @strongify(viewModel);
         [viewModel viewModelDidLoad];
     }];
    
    return viewModel;
}

- (instancetype)initWithService:(id<SSViewModelService>)service fetchParams:(NSDictionary *)params {
    self = [super init];
    if (!self) return nil;
    
    self.service = service;
    
    if (params) {
        self.params4vm = params;
        [self objAllocateValues:params];
    }
    
    return self;
}

- (void)viewModelDidLoad {
    @weakify(self);
    [RACObserve(self, viewModels)
     subscribeNext:^(NSArray *viewModels) {
         @strongify(self);
         self.viewControllers = [viewModels objsMap:^id(id obj, NSInteger index) {
             return [[SSPageRouter sharedRouter] navigationControllerForViewModel:obj];
         }];
    }];
}

- (BOOL)selectWrapperAtIndex:(NSInteger)index {
    return YES;
}

@end
