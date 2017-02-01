//
//  SSTabbarViewModel.h
//  SSKit
//
//  Created by Quincy Yan on 16/3/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SSKitUtility/SSEnums.h>
#import "SSViewModelService.h"

@interface SSTabbarViewModel : NSObject

/**
 初始化方法
 */
- (instancetype)initWithService:(id<SSViewModelService>)service fetchParams:(NSDictionary *)params;

/**
 初始化后调用的方法
 */
- (void)viewModelDidLoad;

@property (nonatomic,strong) id<SSViewModelService> service;
@property (nonatomic) SSPageRouterShowType showType;

/**
 vm中自定义参数
 参数中的键值需与对应‘Controller’的属性名称一致
 以映射相应的数据
 例 : @{@"title":自定义参数} => self.title = @"自定义参数";
 */
@property (nonatomic,strong) NSDictionary *params4vm;

/**
 控制器中自定义参数
 上同
 */
@property (nonatomic,strong) NSDictionary *params4ctr;

@property (nonatomic,strong) NSArray *wrappers;
@property (nonatomic,strong) NSArray *viewModels;
@property (nonatomic,strong) NSArray *viewControllers;

- (BOOL)selectWrapperAtIndex:(NSInteger)index;

@end
