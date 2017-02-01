//
//  SSTableViewModel.h
//  SSKit
//
//  Created by Quincy Yan on 16/3/26.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SSTableViewModel : SSViewModel

/**
 是否加载完成后就刷新
 该值为‘YES’时候, isAllowLoadData为‘YES’
 */
@property (nonatomic,assign) BOOL isLoadDataInitially; // 是否一开始就需要刷新
@property (nonatomic,assign) BOOL isAllowLoadData; // 是否允许刷新
@property (nonatomic,assign) BOOL isAllowLoadAdditionalData; // 是否允许加载更多

@property (nonatomic) NSInteger page; // 当前页码,初始页码为 ‘0’
@property (nonatomic,strong) NSArray *dataSource; // 数据源
@property (nonatomic,strong) RACCommand *requestRemoteDataCommand; // 获取更多数据的指令

/**
 设置初始页码
 */
- (NSInteger)pageForInitial;

/**
 获取数据方法
 */
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

/**
 Cell点击指令

 */
@property (nonatomic,strong) RACCommand *didSelectedCommand;

/**
 默认处理数据回调的方法
 */
- (void)dataSourceHandler:(NSArray *)arr;

@end
