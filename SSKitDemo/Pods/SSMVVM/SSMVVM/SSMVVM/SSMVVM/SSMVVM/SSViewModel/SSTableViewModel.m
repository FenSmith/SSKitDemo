//
//  SSTableViewModel.m
//  SSKit
//
//  Created by Quincy Yan on 16/3/26.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTableViewModel.h"
#import <ReactiveCocoa/RACEXTScope.h>

@implementation SSTableViewModel

- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    
    self.page = 0;
    self.dataSource = [NSMutableArray array];
    
    @weakify(self);
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self);
        return [self requestRemoteDataSignalWithPage:page.unsignedIntegerValue];
    }];
}

- (void)dataSourceHandler:(NSArray *)arr {
    if (arr && arr.count > 0) {
        if (self.page == 0) {
            self.dataSource = arr;
        } else {
            self.dataSource = [self.dataSource arrayByAddingObjectsFromArray:arr];
        }
        self.page ++;
    } else {
        if (self.page == 0) {
            self.dataSource = @[];
        }
    }
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

@end
