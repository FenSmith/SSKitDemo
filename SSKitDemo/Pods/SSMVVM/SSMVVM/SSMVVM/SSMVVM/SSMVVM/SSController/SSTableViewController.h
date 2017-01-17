//
//  SSTableViewController.h
//  SSKit
//
//  Created by Quincy Yan on 16/3/29.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSViewController.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingTableView.h>

@interface SSTableViewController : SSViewController<UITableViewDataSource,UITableViewDelegate>

/**
 视图
 视图默认‘separatorStyle’为‘UITableViewCellSeparatorStyleNone’
 视图尺寸默认充满整个控件
 */
@property (nonatomic,strong) TPKeyboardAvoidingTableView *tableView;

/**
 设置底部视图
 底部视图外部有一层‘View’
 底部视图为于该层‘View’居中,并且距离该‘View’顶部为自身‘Frame’的Y值
 */
- (void)setSheetView:(UIView *)sheetView;

/**
 设置头部视图
 */
- (void)setHeaderView:(UIView *)headerView;

/**
 处理请求开始时候的事件
 */
- (void)dataRequestStart;

/**
 刷新请求第一次请求前的回调
 */
- (void)dataRequestStartOnlyOnce;

/**
 处理成功回调
 只适用于数据接口请求
 */
- (void)dataRequestSuccess:(id)params;

/**
 处理错误回调
 只适用于数据接口请求
 */
- (void)dataRequestError:(NSError *)error;

/**
 处理结束回调
 只适用于数据接口请求
 */
- (void)dataRequestFinished;

@end
