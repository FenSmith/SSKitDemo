//
//  SSView.m
//  SSKit
//
//  Created by Quincy Yan on 16/3/29.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSView.h"
#import "SSViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface SSView()
@property (nonatomic,strong) SSViewModel *viewModel;
@end

@implementation SSView

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    SSView *view = [super allocWithZone:zone];
    
    @weakify(view);
    [[view rac_signalForSelector:@selector(initWithViewModel:)]
     subscribeNext:^(id x) {
         @strongify(view);
         [view bindViewModel];
         [view bindNotifications];
     }];
    
    return view;
}

- (instancetype)initWithViewModel:(SSViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    self.viewModel = viewModel;
    return self;
}

- (void)bindViewModel {
}

- (void)bindNotifications {
}

- (void)dealloc {
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
