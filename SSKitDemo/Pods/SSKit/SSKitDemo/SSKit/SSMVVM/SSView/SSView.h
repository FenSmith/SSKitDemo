//
//  SSView.h
//  SSKit
//
//  Created by Quincy Yan on 16/3/29.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSViewModel;
@interface SSView : UIView

// 初始化视图
- (instancetype)initWithViewModel:(SSViewModel *)viewModel;

// 在初始化后调用
- (void)bindViewModel; // Step1
- (void)bindNotifications; // Step2

@end
