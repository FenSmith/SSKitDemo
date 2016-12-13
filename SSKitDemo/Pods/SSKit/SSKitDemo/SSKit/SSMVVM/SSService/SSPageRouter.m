//
//  SSPageRouter.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/30.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSPageRouter.h"
#import "SSHTTPViewModel.h"
#import "SSTabbarController.h"
#import "SSTabbarViewModel.h"

#import <SSCategory/NSObject+Property.h>

static NSString * const SSPageRouterProtocolIdentity = @"sspage://";
static NSString * const SSPageRouterViewModelIdentity = @"ViewModel";
static NSString * const SSPageRouterControllerIdentity = @"Controller";
static NSString * const SSPageRouterTabbarIdentity = @"tabbar";

@implementation SSPageRouter

+ (SSPageRouter *)sharedRouter {
    static SSPageRouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[SSPageRouter alloc] init];
    });
    return router;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _serviceImpl = [[SSViewModelServiceImpl alloc] init];
    _stacks = [[SSNavigatorStacks alloc] initWithService:_serviceImpl];
    
    self.pagesMapping = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void)registPages:(NSDictionary *)pages {
    if (!pages) return;
    for (NSString *key in pages.allKeys) {
        id object = [pages objectForKey:key];
        if (object) {
            [self.pagesMapping setObject:object forKey:key];
        }
    }
}

- (void)registProtocol:(NSString *)protocol alsoCallback:(SSPageRouterCallback)callback {
    if (!protocol) return;
    [self.pagesMapping setObject:[SSPageRouterObject objectWithCallback:callback] forKey:protocol];
}

- (void)openCallbackProtocol:(NSString *)protocol attachParams:(id)params {
    if (!protocol) return;
    if ([self.pagesMapping.allKeys containsObject:protocol]) {
        SSPageRouterObject *object = [self.pagesMapping objectForKey:protocol];
        if (object.callback) {
            object.callback(params);
        }
    }
}

+ (void)openCallbackProtocol:(NSString *)protocol attachParams:(id)params {
    [[SSPageRouter sharedRouter] openCallbackProtocol:protocol attachParams:params];
}

+ (void)openProtocol:(NSString *)protocol {
    [self openProtocol:protocol viewModelParams:nil];
}

+ (void)openProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params {
    [self openProtocol:protocol viewModelParams:params ctrParams:nil];
}

+ (void)openProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams {
    [self openProtocol:protocol viewModelParams:params ctrParams:ctrParams animated:YES];
}

+ (void)openProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams animated:(BOOL)animated {
    [[SSPageRouter sharedRouter] openProtocol:protocol viewModelParams:params ctrPamams:ctrParams animated:animated showType:SSPageRouterShowTypePush completeHandler:nil];
}

+ (void)presentProtocol:(NSString *)protocol {
    [self presentProtocol:protocol viewModelParams:nil];
}

+ (void)presentProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params {
    [self presentProtocol:protocol viewModelParams:params ctrParams:nil];
}

+ (void)presentProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams {
    [self presentProtocol:protocol viewModelParams:params ctrParams:ctrParams animated:YES];
}

+ (void)presentProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams animated:(BOOL)animated {
    [self presentProtocol:protocol viewModelParams:params ctrParams:ctrParams animated:animated completeHandler:nil];
}

+ (void)presentProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams animated:(BOOL)animated completeHandler:(void (^)())handler {
    [[SSPageRouter sharedRouter] openProtocol:protocol viewModelParams:params ctrPamams:ctrParams animated:animated showType:SSPageRouterShowTypePresent completeHandler:handler];
}

+ (void)resetPageWithProtocol:(NSString *)protocol {
    [self resetPageWithProtocol:protocol viewModelParams:nil];
}

+ (void)resetPageWithProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params {
    [self resetPageWithProtocol:protocol viewModelParams:params ctrParams:nil];
}

+ (void)resetPageWithProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams {
    [[SSPageRouter sharedRouter] openProtocol:protocol viewModelParams:params ctrPamams:ctrParams animated:NO showType:SSPageRouterShowTypeReset completeHandler:nil];
}

+ (void)resetPageWithViewModel:(id)viewModel {
    [[SSPageRouter sharedRouter] filterWithViewModel:viewModel alsoAnimated:YES alsoShowType:SSPageRouterShowTypeReset alsoCompleteHandler:nil];
}

+ (void)openController:(UIViewController *)controller {
    [[SSPageRouter sharedRouter].stacks.topNavigationController pushViewController:controller animated:YES];
}

+ (void)presentController:(UIViewController *)controller {
    [[SSPageRouter sharedRouter].stacks.topNavigationController presentViewController:controller animated:YES completion:nil];
}

+ (void)pagePop:(BOOL)animated {
    [[SSPageRouter sharedRouter].serviceImpl popViewModelAnimated:animated];
}

+ (void)pagePopRoot:(BOOL)animated {
    [[SSPageRouter sharedRouter].serviceImpl popToRootViewModelAnimated:animated];
}

+ (void)pageDismiss:(BOOL)animated alsoCallback:(void (^)())callback {
    [[SSPageRouter sharedRouter].serviceImpl dismissViewModelAnimated:animated completion:callback];
}

- (void)openProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrPamams:(NSDictionary *)ctrParams animated:(BOOL)animated showType:(SSPageRouterShowType)showType completeHandler:(void (^)())handler {
    NSAssert(protocol != nil, @"SSPageRouter - protocol can not be nil !");
    
    id object = [self viewModelFromProtocol:protocol viewModelParams:params];
    if ([object isKindOfClass:[SSViewModel class]]) {
        SSViewModel *viewModel = (SSViewModel *)object;
        viewModel.showType = showType;
        viewModel.params = ctrParams;
        [self filterWithViewModel:viewModel alsoAnimated:animated alsoShowType:showType alsoCompleteHandler:handler];
    } else if ([object isKindOfClass:[SSTabbarViewModel class]]) {
        SSTabbarViewModel *viewModel = (SSTabbarViewModel *)object;
        viewModel.showType = showType;
        viewModel.params = ctrParams;
        [self filterWithViewModel:viewModel alsoAnimated:animated alsoShowType:showType alsoCompleteHandler:handler];
    } else {
        NSLog(@"SSPageRouter can not initialize a viewModel by protocol : %@",protocol);
    }
}

- (id)viewModelFromProtocol:(NSString *)protocol {
    return [self viewModelFromProtocol:protocol viewModelParams:nil];
}

- (id)viewModelFromProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params {
    if ([protocol containsString:SSPageRouterProtocolIdentity]) {
        NSString *str = [protocol substringFromIndex:SSPageRouterProtocolIdentity.length];
        if ([str containsString:SSPageRouterViewModelIdentity]) {
            id viewModel;
            if (params && params.allKeys.count > 0) {
                viewModel = [[NSClassFromString(str) alloc] initWithService:self.serviceImpl alsoViewModleParams:params];
            } else {
                viewModel = [[NSClassFromString(str) alloc] initWithService:self.serviceImpl];
            }
            return viewModel;
        }
    } else if ([protocol containsString:@"http://"] || [protocol containsString:@"https://"]) {
        SSHTTPViewModel *viewModel;
        if (params && params.allKeys.count > 0) {
            viewModel = [[SSHTTPViewModel alloc] initWithService:self.serviceImpl alsoViewModleParams:params];
        } else {
            viewModel = [[SSHTTPViewModel alloc] initWithService:self.serviceImpl];
        }
        viewModel.HTTPUrl = protocol;
        return viewModel;
    }
    return nil;
}

- (void)filterWithViewModel:(id)viewModel alsoAnimated:(BOOL)animated alsoShowType:(SSPageRouterShowType)showType alsoCompleteHandler:(void(^)())completeHandler{
    switch (showType) {
        case SSPageRouterShowTypePush:{
            [self.serviceImpl pushViewModel:viewModel animated:animated];
        }
            break;
        case SSPageRouterShowTypePresent:{
            [self.serviceImpl presentViewModel:viewModel animated:animated completion:completeHandler];
        }
            break;
        case SSPageRouterShowTypeReset:{
            [self.serviceImpl resetRootViewModel:viewModel];
        }
            break;
            
        default:
            break;
    }
}

- (id)viewControllerWithViewModel:(id)viewModel {
    if (!viewModel) return nil;
    
    NSString *className = NSStringFromClass([viewModel class]);
    NSString *ctrName = [className stringByReplacingOccurrencesOfString:SSPageRouterViewModelIdentity withString:SSPageRouterControllerIdentity];
    if ([self.pagesMapping.allKeys containsObject:className]) {
        ctrName = [self.pagesMapping objectForKey:className];
    }
    
    id ctr = [[NSClassFromString(ctrName) alloc] initWithViewModel:viewModel];
    if ([ctr isKindOfClass:[SSTabbarController class]]) {
        return [ctr objAllocateValues:[(SSTabbarViewModel *)viewModel params]];
    } else if ([ctr isKindOfClass:[SSViewController class]]) {
        return [ctr objAllocateValues:[(SSViewModel *)viewModel params]];
    }
    
    return nil;
}

- (SSNavigatorController *)navigationControllerWithViewModel:(SSViewModel *)viewModel {
    SSViewController *ctr = [self viewControllerWithViewModel:viewModel];
    if (ctr) {
        return [[SSNavigatorController alloc] initWithRootViewController:ctr];
    }
    return nil;
}

@end




@implementation SSPageRouterObject

+ (SSPageRouterObject *)objectWithCallback:(SSPageRouterCallback)callback {
    SSPageRouterObject *object = [[SSPageRouterObject alloc] init];
    object.callback = callback;
    return object;
}

@end
