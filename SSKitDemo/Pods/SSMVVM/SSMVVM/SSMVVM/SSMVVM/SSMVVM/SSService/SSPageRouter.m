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
#import "SSNavigatorStacks.h"
#import "SSNavigatorController.h"
#import "SSViewModelServiceImpl.h"
#import "SSViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <SSKitUtility/NSObject+Property.h>

@interface SSPageRouter()
@property (nonatomic,strong) NSMutableDictionary *pagesMapping;

@end

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
    _pagesMapping = [[NSMutableDictionary alloc] init];
    
    return self;
}

+ (void)callProtocol:(NSString *)protocol {
    [self callProtocol:protocol fetchParams:nil];
}

+ (void)callProtocol:(NSString *)protocol fetchParams:(NSDictionary *)params {
    [[SSPageRouter sharedRouter] callProtocol:protocol fetchParams:params];
}

+ (void)removeProtocol:(NSString *)protocol {
    [[SSPageRouter sharedRouter] removeProtocol:protocol];
}

+ (void)responseProtocol:(NSString *)protocol forCallback:(SSPageRouterActionBlock)callback {
    [[SSPageRouter sharedRouter] responseProtocol:protocol forCallback:callback];
}

- (void)callProtocol:(NSString *)protocol fetchParams:(NSDictionary *)params {
    if (![self _isProtocolValid:protocol]) return;
    
    NSString *key = [self encodeProtocol:protocol];
    BOOL isRegisted = [self _isKeyRegisted:key];
    if (!isRegisted) return;
    
    SSPageRouterActionBlock callback = [_pagesMapping objectForKey:key];
    if (callback) {
        callback(params);
    }
}

- (void)removeProtocol:(NSString *)protocol {
    if (![self _isProtocolValid:protocol]) return;
    
    NSString *key = [self encodeProtocol:protocol];
    BOOL isRegisted = [self _isKeyRegisted:key];
    if (!isRegisted) return;
    
    @synchronized (self) {
        [_pagesMapping removeObjectForKey:key];
    }
}

- (void)responseProtocol:(NSString *)protocol forCallback:(SSPageRouterActionBlock)callback {
    if (![self _isProtocolValid:protocol]) return;
    if (!callback) return;
    
    @synchronized (self) {
        NSString *key = [self encodeProtocol:protocol];
        [_pagesMapping setObject:[callback copy] forKey:key];
    }
}

- (BOOL)_isProtocolValid:(NSString *)protocol {
    if (!protocol || protocol.length == 0) return NO;
    if (![self _isProtocolContainsScheme:protocol]) return NO;
    return YES;
}

- (BOOL)_isProtocolContainsScheme:(NSString *)protocol {
    return [protocol hasPrefix:SSPR_SCHEME_MARK];
}

- (BOOL)_isProtocolRegisted:(NSString *)protocol {
    NSString *key = [self encodeProtocol:protocol];
    return [self _isKeyRegisted:key];
}

- (BOOL)_isKeyRegisted:(NSString *)key {
    if (!key || key.length == 0) return NO;
    return [_pagesMapping.allKeys containsObject:key];
}

- (NSString *)encodeProtocol:(NSString *)protocol {
    const char *str = [protocol UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *name = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                      r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                      r[11], r[12], r[13], r[14], r[15], [[protocol pathExtension] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", [protocol pathExtension]]];
    
    return name;
}

// open
+ (RACSignal *)openProtocol:(NSString *)aProtocol {
    return [SSPageRouter openProtocol:aProtocol fetchParams:nil];
}

+ (RACSignal *)openProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params {
    return [SSPageRouter openProtocol:aProtocol fetchParams:params fetchControllerParams:nil];
}

+ (RACSignal *)openProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams {
    return [SSPageRouter openProtocol:aProtocol fetchParams:params fetchControllerParams:cParams isAnimated:YES];
}

+ (RACSignal *)openProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams isAnimated:(BOOL)isAnimated {
    return [[SSPageRouter sharedRouter] openProtocol:aProtocol fetchParams:params fetchControllerParams:cParams isAnimated:isAnimated];
}

// present
+ (RACSignal *)presentProtocol:(NSString *)aProtocol {
    return [SSPageRouter presentProtocol:aProtocol fetchParams:nil];
}

+ (RACSignal *)presentProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params {
    return [SSPageRouter presentProtocol:aProtocol fetchParams:params fetchControllerParams:nil];
}

+ (RACSignal *)presentProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams {
    return [SSPageRouter presentProtocol:aProtocol fetchParams:params fetchControllerParams:cParams fetchVoidBlock:nil isAnimated:YES];
}

+ (RACSignal *)presentProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams fetchVoidBlock:(SSMVVMVoidBlock)block isAnimated:(BOOL)isAnimated {
    return [[SSPageRouter sharedRouter] presentProtocol:aProtocol fetchParams:params fetchControllerParams:cParams fetchVoidBlock:block isAnimated:isAnimated];
}

// reset
+ (void)resetPageAttachProtocol:(NSString *)aProtocol {
    [SSPageRouter resetPageAttachProtocol:aProtocol fetchParams:nil];
}

+ (void)resetPageAttachProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params {
    [SSPageRouter resetPageAttachProtocol:aProtocol fetchParams:params fetchControllerParams:nil];
}

+ (void)resetPageAttachProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams {
    [[SSPageRouter sharedRouter] resetPageAttachProtocol:aProtocol fetchParams:params fetchControllerParams:cParams];
}

// close
+ (void)closePage {
    [[SSPageRouter sharedRouter] closePageAtIndex:MAXFLOAT fetchVoidBlock:nil isAnimated:NO];
}

+ (void)closePageWithAnimation {
    [[SSPageRouter sharedRouter] closePageAtIndex:MAXFLOAT fetchVoidBlock:nil isAnimated:YES];
}

+ (void)closePageAtIndex:(NSInteger)index {
    [[SSPageRouter sharedRouter] closePageAtIndex:index fetchVoidBlock:nil isAnimated:NO];
}

+ (void)closePageAttachProtocol:(NSString *)aProtocol {
    [[SSPageRouter sharedRouter] closePageAttachProtocol:aProtocol];
}

+ (void)closePageAttachVoidBlock:(SSMVVMVoidBlock)block isAnimated:(BOOL)isAnimated {
    [[SSPageRouter sharedRouter] closePageAtIndex:MAXFLOAT fetchVoidBlock:block isAnimated:isAnimated];
}

- (void)closePageAtIndex:(NSInteger)index fetchVoidBlock:(SSMVVMVoidBlock)block isAnimated:(BOOL)isAnimated {
    NSInteger count = _stacks.topNavigationController.viewControllers.count;
    if (count < index && index < 100) return;
    
    if (block) {
        [_serviceImpl dismissViewModelAnimated:isAnimated completion:block];
        return;
    }
    
    if (index > 100 || index == count - 1) {
        [_stacks.topNavigationController popViewControllerAnimated:isAnimated];
        return;
    }
    
    if (index != count - 1) {
        NSMutableArray *vcs = [[_stacks.topNavigationController viewControllers] mutableCopy];
        [vcs removeObjectAtIndex:index];
        _stacks.topNavigationController.viewControllers = [vcs copy];
        return;
    }
}

- (void)closePageAttachProtocol:(NSString *)aProtocol {
    SSViewController *vc = [self viewControllerForProtocol:aProtocol fetchParams:nil fetchControllerParams:nil];
    NSArray *vcs = _stacks.topNavigationController.viewControllers;
    Class class = vc.class;
    
    for (UIViewController *vct in vcs) {
        if ([vct isKindOfClass:class]) {
            NSInteger index = [vcs indexOfObject:vct];
            [self closePageAtIndex:index fetchVoidBlock:nil isAnimated:YES];
            break;
        }
    }
}

- (RACSignal *)openProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams isAnimated:(BOOL)isAnimated {
    SSViewModel *vm = [self viewModelForProtocol:aProtocol fetchParams:params];
    if (vm) {
        vm.showType = SSPageRouterShowTypePush;
        vm.params4ctr = cParams;
        [_serviceImpl pushViewModel:vm animated:isAnimated];
    }
    return [RACSignal empty];
}

- (RACSignal *)presentProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams fetchVoidBlock:(SSMVVMVoidBlock)block isAnimated:(BOOL)isAnimated {
    SSViewModel *vm = [self viewModelForProtocol:aProtocol fetchParams:params];
    if (vm) {
        vm.showType = SSPageRouterShowTypePresent;
        vm.params4ctr = cParams;
        [_serviceImpl presentViewModel:vm animated:isAnimated completion:block];
    }
    return [RACSignal empty];
}

- (void)resetPageAttachProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams {
    SSViewModel *vm = [self viewModelForProtocol:aProtocol fetchParams:params];
    if (vm) {
        vm.showType = SSPageRouterShowTypeReset;
        vm.params4ctr = cParams;
        [_serviceImpl resetRootViewModel:vm];
    }
}

- (id)viewModelForProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params {
    if (![self isProtocolValid:aProtocol]) return nil;
    
    NSString *vm = [aProtocol substringFromIndex:SSPR_SCHEME_MARK.length];
    SSPageRouterType type = [self typeForProtocol:aProtocol];
    if (type == SSPageRouterTypeUnknow) return nil;
    
    Class class = NSClassFromString(vm);
    if (type == SSPageRouterTypeWebView) {
        class = [SSHTTPViewModel class];
    }

    return [[class alloc] initWithService:_serviceImpl fetchParams:params];
}

- (id)viewControllerForProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams {
    if (![self isProtocolValid:aProtocol]) return [self defaultViewController];
    
    id viewModel = [self viewModelForProtocol:aProtocol fetchParams:params];
    if (!viewModel) return [self defaultViewController];
    
    return [self viewControllerForViewModel:viewModel fetchControllerParams:cParams];
}

- (id)viewControllerForViewModel:(id)viewModel fetchControllerParams:(NSDictionary *)cParams {
    if (!viewModel) return [self defaultViewController];
    
    NSString *vm = NSStringFromClass([viewModel class]);
    NSString *vm2 = [vm stringByReplacingOccurrencesOfString:SSPR_VIEWMODEL_MARK withString:SSPR_CONTROLLER_MARK];
    
    id controller = [[NSClassFromString(vm2) alloc] initWithViewModel:viewModel];
    if (!controller) return [self defaultViewController];
    
    [controller objAllocateValues:cParams];
    return controller;
}

+ (void)openViewController:(UIViewController *)controller isAnimated:(BOOL)isAnimated {
    [[SSPageRouter sharedRouter].stacks.topNavigationController pushViewController:controller animated:isAnimated];
}

+ (void)presentViewController:(UIViewController *)controller fetchVoidBlock:(SSMVVMVoidBlock)block isAnimated:(BOOL)isAnimated {
    [[SSPageRouter sharedRouter].stacks.topNavigationController presentViewController:controller animated:isAnimated completion:block];
}

- (SSNavigatorController *)navigationControllerForViewModel:(SSViewModel *)viewModel {
    if (!viewModel) return [self defaultNavigationController];
    
    SSViewController *vc = [self viewControllerForViewModel:viewModel fetchControllerParams:nil];
    if (!vc) return [self defaultNavigationController];
    return [[SSNavigatorController alloc] initWithRootViewController:vc];
}

- (SSNavigatorController *)defaultNavigationController {
    return [[SSNavigatorController alloc] initWithRootViewController:[self defaultViewController]];
}

- (SSViewController *)defaultViewController {
    return [self viewControllerForProtocol:[NSString stringWithFormat:@"%@SSViewModel",SSPR_SCHEME_MARK] fetchParams:nil fetchControllerParams:nil];
}

- (SSPageRouterType)typeForProtocol:(NSString *)aProtocol {
    if (!aProtocol || aProtocol.length == 0) return SSPageRouterTypeUnknow;
    if (![aProtocol hasPrefix:SSPR_SCHEME_MARK]) return SSPageRouterTypeUnknow;
    
    NSString *vm = [aProtocol substringFromIndex:SSPR_SCHEME_MARK.length];
    if ([vm containsString:@"http://"] || [vm containsString:@"https://"]) return SSPageRouterTypeWebView;
    
    Class class = NSClassFromString(vm);
    if (!class) return SSPageRouterTypeUnknow;
    
    if ([vm containsString:SSPR_TABBAR_MARK]) return SSPageRouterTypeTabbar;
    return SSPageRouterTypePage;
}

- (SSPageRouterType)typeForViewModel:(id)viewModel {
    if ([viewModel isKindOfClass:[SSTabbarViewModel class]]) {
        return SSPageRouterTypeTabbar;
    } else if ([viewModel isKindOfClass:[SSViewModel class]]) {
        return SSPageRouterTypePage;
    } else if ([viewModel isKindOfClass:[SSHTTPViewModel class]]) {
        return SSPageRouterTypeWebView;
    }
    return SSPageRouterTypeUnknow;
}

- (BOOL)isProtocolValid:(NSString *)aProtocol {
    if (!aProtocol || aProtocol.length == 0) return NO;
    if (![aProtocol hasPrefix:SSPR_SCHEME_MARK]) return NO;
    return YES;
}

@end
