//
//  SSNavigatorController.m
//  SSKit
//
//  Created by Quincy Yan on 16/3/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSNavigatorController.h"

@interface SSNavigatorController ()

@end

@implementation SSNavigatorController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
