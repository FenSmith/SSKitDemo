//
//  SSTabbarViewModel.h
//  SSKit
//
//  Created by Quincy Yan on 16/3/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSViewModelService.h"
#import <SSConfigure/SSEnums.h>

@interface SSTabbarViewModel : NSObject

// 初始化后调用的方法
- (void)viewModelDidLoad;

// 初始化方法
- (instancetype)initWithService:(id<SSViewModelService>)service;

@property (nonatomic,strong) id<SSViewModelService> service;
@property (nonatomic) SSPageRouterShowType showType;

@property (nonatomic,strong) NSDictionary *params;

@property (nonatomic,strong) NSArray *entitys;
@property (nonatomic,strong) NSArray *viewModels;
@property (nonatomic,strong) NSArray *viewControllers;

- (BOOL)selectedHandlerAtIndex:(NSInteger)index;

@end
