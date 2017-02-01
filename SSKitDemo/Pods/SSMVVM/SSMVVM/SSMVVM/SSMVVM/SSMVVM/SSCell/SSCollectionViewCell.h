//
//  SSCollectionViewCell.h
//  SSKit
//
//  Created by Quincy Yan on 16/5/19.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSViewModel;
@interface SSCollectionViewCell : UICollectionViewCell

/**
 绑定模型
 */
- (void)bindWithDataSource:(NSObject *)dataSource;

/**
 绑定‘ViewModel‘
 */
- (void)bindWithViewModel:(SSViewModel *)viewModel forIndexPath:(NSIndexPath *)indexPath;

/**
 绑定‘ViewModel‘以及赋值
 */
- (void)bindWithViewModel:(SSViewModel *)viewModel fetchDataSource:(NSObject *)dataSource forIndexPath:(NSIndexPath *)indexPath;

@end
