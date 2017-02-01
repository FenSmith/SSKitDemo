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

#import <SSKitUtility/UIImage+SSKit.h>
#import <SSKitUtility/NSObject+Property.h>
#import <SSKitUtility/SSAppHandler.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface SSViewModel()

@end

@implementation SSViewModel 

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    SSViewModel *viewModel = [super allocWithZone:zone];
    
    @weakify(viewModel);
    RACSignal *initialParamsSignal = [viewModel rac_signalForSelector:@selector(initWithService:fetchParams:)];
    
    [[RACSignal merge:@[initialParamsSignal]]
     subscribeNext:^(id x) {
         @strongify(viewModel);
         [viewModel viewModelDidLoad];
         [viewModel viewModelLoadNotifications];
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
    self.leftBarButtons = @[];
    self.rightBarButtons = @[];
    self.titleType = [SSAppHandler sharedHander].navigationTitleType;
    self.title = [self titleForViewModel];
    
    @weakify(self);
    self.backBarCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        switch (self.showType) {
            case SSPageRouterShowTypePresent:{
                [SSPageRouter closePageAttachVoidBlock:nil isAnimated:YES];
            }
                break;
            case SSPageRouterShowTypePush:{
                [SSPageRouter closePageWithAnimation];
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
    
    if (![self hidesReturnNavigaionItem] && [SSAppHandler sharedHander].navigationTitleType == SSPageTitleTypeCenter) {
        self.leftBarButtons = @[[SSBarEntity setupEntityWithNormalImage:[SSAppHandler sharedHander].navigationbarImage
                                                     withHighlightImage:[SSAppHandler sharedHander].navigationbarHighlightImage]];
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

- (BOOL)hidesReturnNavigaionItem {
    return NO;
}

- (void)dealloc {
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
