//
//  SSPageRouter.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/30.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSNavigatorStacks.h"
#import "SSNavigatorController.h"
#import "SSViewModelServiceImpl.h"
#import "SSViewController.h"

typedef NS_ENUM(NSInteger,SSPageRouterType) {
    SSPageRouterTypeError = 0,
    SSPageRouterTypePage = 1,
    SSPageRouterTypeWebView = 2,
};

typedef void (^ SSPageRouterCallback)(id params);

@interface SSPageRouter : NSObject

+ (SSPageRouter *)sharedRouter;

@property (nonatomic,strong) NSMutableDictionary *pagesMapping;
@property (nonatomic,strong) SSNavigatorStacks *stacks;
@property (nonatomic,strong) SSViewModelServiceImpl *serviceImpl;

- (void)registPages:(NSDictionary *)pages;
- (void)registProtocol:(NSString *)protocol alsoCallback:(SSPageRouterCallback)callback;

/**
 根据协议生成控制器
 协议中的‘viewModel’需要已经注册
 协议有对应关系
 例如 SSIndexViewModel 与 SSIndexController, 如果这两个文件名都已经存在, 则无须注册
 例如 SSIndexViewModel 需要特殊对应 SSPageController, 则需要注册
 
 协议规则
 1. 打开Page : sspage://indexViewModel
 2. 打开Web Page : http://www.baidu.com 或者 https://www.baidu.com
 */

+ (void)openCallbackProtocol:(NSString *)protocol attachParams:(id)params;

/**
 protocol:打开的具体协议
 params:viewModel中分配的属性
 ctrParams:viewController中分配的属性
 默认打开一个viewModle是有动画的 animated = YES
 */
+ (void)openProtocol:(NSString *)protocol;
+ (void)openProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params;
+ (void)openProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams;
+ (void)openProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams animated:(BOOL)animated;

+ (void)presentProtocol:(NSString *)protocol;
+ (void)presentProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params;
+ (void)presentProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams;
+ (void)presentProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams animated:(BOOL)animated;
+ (void)presentProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams animated:(BOOL)animated completeHandler:(void(^)())handler;

+ (void)resetPageWithViewModel:(id)viewModel;
+ (void)resetPageWithProtocol:(NSString *)protocol;
+ (void)resetPageWithProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params;
+ (void)resetPageWithProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params ctrParams:(NSDictionary *)ctrParams;

+ (void)openController:(UIViewController *)controller;
+ (void)presentController:(UIViewController *)controller;

- (id)viewControllerWithViewModel:(SSViewModel *)viewModel;
- (SSNavigatorController *)navigationControllerWithViewModel:(SSViewModel *)viewModel;

+ (void)pagePop:(BOOL)animated;
+ (void)pagePopRoot:(BOOL)animated;
+ (void)pageDismiss:(BOOL)animated alsoCallback:(void (^)())callback;

- (id)viewModelFromProtocol:(NSString *)protocol;
- (id)viewModelFromProtocol:(NSString *)protocol viewModelParams:(NSDictionary *)params;

@end




@interface SSPageRouterObject : NSObject

@property (nonatomic,copy) SSPageRouterCallback callback;
+ (SSPageRouterObject *)objectWithCallback:(SSPageRouterCallback)callback;

@end
