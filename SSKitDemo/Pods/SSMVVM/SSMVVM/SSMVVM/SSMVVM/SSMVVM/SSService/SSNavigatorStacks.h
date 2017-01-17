//
//  SSNavigatorStacks.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/12.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSViewModelService.h"

@class SSNavigatorController;
@interface SSNavigatorStacks : NSObject

- (instancetype)initWithService:(id<SSViewModelService>)service;

- (void)pushNavigationController:(SSNavigatorController *)navigationController;
- (void)popNavigationController;
- (SSNavigatorController *)topNavigationController;

@end
