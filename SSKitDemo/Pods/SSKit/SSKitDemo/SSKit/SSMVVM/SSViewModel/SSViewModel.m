//
//  SSViewModel.m
//  SSKit
//
//  Created by Quincy Yan on 16/3/26.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSViewModel.h"
#import "SSPageRouter.h"
#import "SSBarEntity.h"

#import <SSCategory/UIImage+SSKit.h>
#import <SSCategory/NSObject+Property.h>
#import <SSHandler/SSAppHandler.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface SSViewModel()

@end

@implementation SSViewModel 

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    SSViewModel *viewModel = [super allocWithZone:zone];
    
    @weakify(viewModel);
    RACSignal *initialSignal = [viewModel rac_signalForSelector:@selector(initWithService:)];
    RACSignal *initialTitleSignal = [viewModel rac_signalForSelector:@selector(initWithService:alsoTitle:)];
    RACSignal *initialParamsSignal = [viewModel rac_signalForSelector:@selector(initWithService:alsoViewModleParams:)];
    
    [[RACSignal merge:@[initialSignal,
                       initialTitleSignal,
                       initialParamsSignal]]
     subscribeNext:^(id x) {
         @strongify(viewModel);
         [viewModel viewModelDidLoad];
         [viewModel viewModelLoadNotifications];
    }];
    
    return viewModel;
}

- (instancetype)initWithService:(id<SSViewModelService>)service {
    self = [super init];
    if (!self) return nil;
    self.service = service;
    return self;
}

- (instancetype)initWithService:(id<SSViewModelService>)service alsoViewModleParams:(NSDictionary *)params {
    self = [super init];
    if (!self) return nil;
    self.service = service;
    self.viewModelParams = params;
    [self objAllocateValues:params];
    return self;
}

- (instancetype)initWithService:(id<SSViewModelService>)service alsoTitle:(NSString *)title {
    self = [super init];
    if (!self) return nil;
    self.service = service;
    self.title = title;
    return self;
}

- (void)viewModelDidLoad {
    self.leftBarButtons = @[];
    self.rightBarButtons = @[];
    self.titleType = [SSAppHandler sharedHander].navigationTitleType;
    self.title = [self titleForViewModel];
    
    @weakify(self);
    self.backBarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        switch (self.showType) {
            case SSPageRouterShowTypePresent:{
                [SSPageRouter pageDismiss:YES alsoCallback:nil];
            }
                break;
            case SSPageRouterShowTypePush:{
                [SSPageRouter pagePop:YES];
            }
                break;
            default:
                break;
        }
        return [RACSignal empty];
    }];
    
    self.leftBarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *index) {
        @strongify(self);
        return [self leftBarItemClickedCallback:index.integerValue];
    }];
    
    self.rightBarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *index) {
        @strongify(self);
        return [self rightBarItemClickedCallback:index.integerValue];
    }];
    
    if (![self hidesReturnButton] && [SSAppHandler sharedHander].navigationTitleType == SSPageTitleTypeCenter) {
        self.leftBarButtons = @[[SSBarEntity entityContainsImage:[SSAppHandler sharedHander].navigationbarImage
                                                  highlightImage:[SSAppHandler sharedHander].navigationbarHighlightImage]];
    }
};

- (RACSignal *)leftBarItemClickedCallback:(NSInteger)index {
    return [RACSignal empty];
}

- (RACSignal *)rightBarItemClickedCallback:(NSInteger)index {
    return [RACSignal empty];
}

- (NSString *)titleForViewModel {
    return @"";
}

- (void)viewModelLoadNotifications {
    
}

- (BOOL)hidesReturnButton {
    return NO;
}

- (void)dealloc {
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
