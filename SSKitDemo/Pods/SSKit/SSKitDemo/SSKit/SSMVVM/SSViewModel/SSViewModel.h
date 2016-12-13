//
//  SSViewModel.h
//  SSKit
//
//  Created by Quincy Yan on 16/3/26.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSViewModelService.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SSConfigure/SSEnums.h>

@interface SSViewModel : NSObject

// 初始化方法
- (instancetype)initWithService:(id<SSViewModelService>)service;
- (instancetype)initWithService:(id<SSViewModelService>)service alsoViewModleParams:(NSDictionary *)params;
- (instancetype)initWithService:(id<SSViewModelService>)service alsoTitle:(NSString *)title;

// 初始化后调用的方法
- (void)viewModelDidLoad; // Step1
- (void)viewModelLoadNotifications; // Step2

/**
 用于页面跳转逻辑
 例 : [self.service pushViewModel:XXX animated:YES]
 */
@property (nonatomic,strong) id<SSViewModelService> service;
@property (nonatomic) SSPageRouterShowType showType;
@property (nonatomic) SSPageTitleType titleType;

/**
 自定义参数
 参数中的键值需与对应‘Controller’的属性名称一致
 以映射相应的数据
 例 : @{@"title":自定义参数} => self.title = @"自定义参数";
 */
@property (nonatomic,strong) NSDictionary *params;

/**
 viewModel中的参数
 */
@property (nonatomic,strong) NSDictionary *viewModelParams;

@property (nonatomic,copy) NSString *title; // 控制器标题
- (NSString *)titleForViewModel;

/**
 自定义导航栏左侧按钮
 可以接收的子集类型为 => "NSString", "SSBarEntity"
 当类型为‘NSString’时,显示一个字体大小为15,颜色为’SS_BarEntity_TitleColor‘
 当类型为’SSBarEntity‘时,具体情况可定制
 */
@property (nonatomic,strong) NSArray *leftBarButtons; // 导航栏左侧按钮
@property (nonatomic,strong) RACCommand *leftBarCommand; // 左侧按钮点击指令
@property (nonatomic,strong) NSArray *rightBarButtons; // 右侧按钮标题
@property (nonatomic,strong) RACCommand *rightBarCommand; // 右侧按钮点击指令
@property (nonatomic,strong) RACCommand *backBarCommand; // 返回按钮点击指令

- (RACSignal *)leftBarItemClickedCallback:(NSInteger)index;
- (RACSignal *)rightBarItemClickedCallback:(NSInteger)index;

/**
 是否隐藏默认加载的返回按钮
 默认为'NO' 不隐藏
 */
- (BOOL)hidesReturnButton;

@end
