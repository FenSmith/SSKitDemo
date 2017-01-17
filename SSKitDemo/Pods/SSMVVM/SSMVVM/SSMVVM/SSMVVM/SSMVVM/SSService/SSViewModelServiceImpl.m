//
//  SSViewModelServiceImpl.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/12.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSViewModelServiceImpl.h"

@implementation SSViewModelServiceImpl

- (void)pushViewModel:(SSViewModel *)viewModel animated:(BOOL)animated{}

- (void)popViewModelAnimated:(BOOL)animated{}

- (void)popToRootViewModelAnimated:(BOOL)animated{}

- (void)presentViewModel:(SSViewModel *)viewModel animated:(BOOL)animated completion:(ssVoidBlock)completion{}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(ssVoidBlock)completion{}

- (void)resetRootViewModel:(SSViewModel *)viewModel{}

@end
