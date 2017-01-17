//
//  SSTableViewCell.h
//  SSKit
//
//  Created by Quincy Yan on 16/4/7.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSViewModel.h"

typedef void (^ TextCallback)(NSString *str);

@interface SSTableViewCell : UITableViewCell

// 绑定模型
- (void)bindWithDataSource:(NSObject *)dataSource indexPath:(NSIndexPath *)indexPath;

// 绑定‘ViewModel‘
- (void)bindWithViewModel:(SSViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;

// 绑定‘ViewModel‘以及赋值
- (void)bindWithViewModel:(SSViewModel *)viewModel dataSource:(NSObject *)dataSource indexPath:(NSIndexPath *)indexPath;

// 计算高度
+ (CGFloat)cellHeightWithModel:(NSObject *)model;

@end
