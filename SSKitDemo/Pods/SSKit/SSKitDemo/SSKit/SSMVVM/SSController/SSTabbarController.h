//
//  SSTabbarController.h
//  SSKit
//
//  Created by Quincy Yan on 16/4/23.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSTabbarViewModel;
@interface SSTabbarController : UITabBarController

// 初始化视图
- (instancetype)initWithViewModel:(SSTabbarViewModel *)viewModel;

// 初始化后调用的方法
- (void)bindInitialization; /// Step1
- (void)bindNotification; /// Step2
- (void)bindViewModel; /// Step3

@end
