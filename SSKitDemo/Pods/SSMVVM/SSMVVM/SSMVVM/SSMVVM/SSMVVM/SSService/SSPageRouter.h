//
//  SSPageRouter.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/30.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSMVVMBlocks.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@class SSNavigatorStacks;
@class SSNavigatorController;
@class SSViewModelServiceImpl;
@class SSViewController;
@class SSViewModel;

/**
 SSPR_SCHEME_MARK : 协议标志,所有的跳转、请求协议必须有该协议头
 SSPR_VIEWMODEL_MARK : ViewModel标志,该标志用于检测是否跳转的是ViewModel还是普通的HTTP
 SSPR_CONTROLLER_MARK : ViewModel与ViewController需要根据名称映射成具体的实例,该标志用于ViewModel转换成具体的Controller
 例如:SSTestViewModel -> SSTestController, 如果SSPR_VIEWMODEL_MARK与SSPR_CONTROLLER_MARK分别为‘ViewModel’与‘Controller’,则会进行替换,并且映射成具体的类
 如果SSPR_VIEWMODEL_MARK与SSPR_CONTROLLER_MARK分别为‘ViewModel’与‘ViewController’,当SSTestViewModel转换成SSTestViewController时,由于实际文件名为SSTestController,会无法
 映射成具体的类
 SSPR_TABBAR_MARK : SSTabbarViewModel不是继承自SSViewModel,两个类类似但是没有关系，所有需要根据这个关键字进行区分以映射不同的类
 */
static NSString * const SSPR_SCHEME_MARK = @"sspr://";
static NSString * const SSPR_VIEWMODEL_MARK = @"ViewModel";
static NSString * const SSPR_CONTROLLER_MARK = @"Controller";
static NSString * const SSPR_TABBAR_MARK = @"Tabbar";

typedef void (^ SSPageRouterActionBlock)(id params);

typedef NS_ENUM(NSInteger,SSPageRouterType) {
    SSPageRouterTypeUnknow = 0,
    SSPageRouterTypePage = 1,
    SSPageRouterTypeWebView = 2,
    SSPageRouterTypeTabbar = 3,
};

@interface SSPageRouter : NSObject

+ (SSPageRouter *)sharedRouter;

@property (nonatomic,strong) SSNavigatorStacks *stacks;
@property (nonatomic,strong) SSViewModelServiceImpl *serviceImpl;

///---------------------------------
/// 普通方法,相当于NSNotificationCenter
///---------------------------------
+ (void)callProtocol:(NSString *)protocol;
+ (void)callProtocol:(NSString *)protocol fetchParams:(NSDictionary *)params;
+ (void)responseProtocol:(NSString *)protocol forCallback:(SSPageRouterActionBlock)callback;
+ (void)removeProtocol:(NSString *)protocol;

///--------------
/// 用于基本页面跳转
///--------------
+ (RACSignal *)openProtocol:(NSString *)aProtocol;
+ (RACSignal *)openProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params;
+ (RACSignal *)openProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams;
+ (RACSignal *)openProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams isAnimated:(BOOL)isAnimated;

+ (RACSignal *)presentProtocol:(NSString *)aProtocol;
+ (RACSignal *)presentProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params;
+ (RACSignal *)presentProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams;
+ (RACSignal *)presentProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams fetchVoidBlock:(SSMVVMVoidBlock)block isAnimated:(BOOL)isAnimated;

+ (void)resetPageAttachProtocol:(NSString *)aProtocol;
+ (void)resetPageAttachProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params;
+ (void)resetPageAttachProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams;

+ (void)closePage;
+ (void)closePageWithAnimation;
+ (void)closePageAttachProtocol:(NSString *)aProtocol;
+ (void)closePageAtIndex:(NSInteger)index;
+ (void)closePageAttachVoidBlock:(SSMVVMVoidBlock)block isAnimated:(BOOL)isAnimated;

+ (void)openViewController:(UIViewController *)controller isAnimated:(BOOL)isAnimated;
+ (void)presentViewController:(UIViewController *)controller fetchVoidBlock:(SSMVVMVoidBlock)block isAnimated:(BOOL)isAnimated;

///-----------
/// 类具体的方法
///-----------

// 返回可能是SSTabbarViewModel/SSViewModel
- (id)viewModelForProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params;
- (id)viewControllerForProtocol:(NSString *)aProtocol fetchParams:(NSDictionary *)params fetchControllerParams:(NSDictionary *)cParams;
- (id)viewControllerForViewModel:(SSViewModel *)viewModel fetchControllerParams:(NSDictionary *)cParams;
- (SSNavigatorController *)navigationControllerForViewModel:(SSViewModel *)viewModel;

///--------
/// 默认变量
///--------
- (SSNavigatorController *)defaultNavigationController;
- (SSViewController *)defaultViewController;

@end
