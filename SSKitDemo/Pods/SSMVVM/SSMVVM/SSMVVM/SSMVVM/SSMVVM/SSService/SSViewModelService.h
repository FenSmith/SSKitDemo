//
//  SSViewModelService.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/12.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ ssVoidBlock)();

@class SSViewModel;
@protocol SSViewModelService <NSObject>

// 跳转一个控制器
- (void)pushViewModel:(SSViewModel *)viewModel animated:(BOOL)animated;

// 切回一个控制器
- (void)popViewModelAnimated:(BOOL)animated;

// 切回至根视图
- (void)popToRootViewModelAnimated:(BOOL)animated;

// 呈现一个视图
- (void)presentViewModel:(SSViewModel *)viewModel animated:(BOOL)animated completion:(ssVoidBlock)completion;

// 取消一个视图
- (void)dismissViewModelAnimated:(BOOL)animated completion:(ssVoidBlock)completion;

// 重新设置一个根视图
- (void)resetRootViewModel:(SSViewModel *)viewModel;

@end
