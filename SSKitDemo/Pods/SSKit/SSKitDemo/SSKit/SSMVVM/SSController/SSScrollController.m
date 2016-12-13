//
//  SSScrollController.m
//  SSKit
//
//  Created by Quincy Yan on 16/4/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSScrollController.h"
#import <Masonry/Masonry.h>

@interface SSScrollController()

@end

@implementation SSScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (TPKeyboardAvoidingScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _scrollView;
}

@end
