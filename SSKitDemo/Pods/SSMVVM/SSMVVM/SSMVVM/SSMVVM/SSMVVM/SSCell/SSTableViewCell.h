//
//  SSTableViewCell.h
//  SSKit
//
//  Created by Quincy Yan on 16/4/7.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSViewModel;
@interface SSTableViewCell : UITableViewCell

/**
 绑定模型
 */
- (void)bindWithDataSource:(NSObject *)dataSource forIndexPath:(NSIndexPath *)indexPath;

/**
 绑定‘ViewModel‘
 */
- (void)bindWithViewModel:(SSViewModel *)viewModel forIndexPath:(NSIndexPath *)indexPath;

/**
 绑定‘ViewModel‘以及赋值
 */
- (void)bindWithViewModel:(SSViewModel *)viewModel fetchDataSource:(NSObject *)dataSource forIndexPath:(NSIndexPath *)indexPath;

/**
 计算高度
 */
+ (CGFloat)cellHeightWithModel:(NSObject *)model;

@end
