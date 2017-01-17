//
//  SSCollectionViewCell.h
//  SSKit
//
//  Created by Quincy Yan on 16/5/19.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSViewModel.h"

@interface SSCollectionViewCell : UICollectionViewCell

// 绑定模型
- (void)bindWithDataSource:(NSObject *)dataSource;

// 绑定‘ViewModel‘
- (void)bindWithViewModel:(SSViewModel *)viewModel andIndexpath:(NSIndexPath *)indexpath;

// 绑定‘ViewModel‘以及赋值
- (void)bindWithViewModel:(SSViewModel *)viewModel dataSource:(NSObject *)dataSource indexpath:(NSIndexPath *)indexpath;

@end
