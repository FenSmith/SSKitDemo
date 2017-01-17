//
//  SSViewController.h
//  SSKit
//
//  Created by Quincy Yan on 16/3/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSViewModel;
@interface SSViewController : UIViewController

// 初始化视图
- (instancetype)initWithViewModel:(SSViewModel *)viewModel;

// 初始化后调用的方法
- (void)bindInitialization; /// Step1
- (void)bindNotification; /// Step2
- (void)bindViewModel; /// Step3

- (void)clearNavigationBar;
- (void)resetNavibarColor:(UIColor *)color;
- (void)resetTitleColor:(UIColor *)color;
- (void)resetShadowSpliter;

@end
