//
//  SSProgressView.h
//  SSKit
//
//  Created by Quincy Yan on 16/8/17.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSProgressView : UIView

/**
 填充颜色
 默认为'77,169,52'
 */
@property (nonatomic,strong) UIColor *fillColor;

/**
 是否停止后隐藏
 默认为 YES
 */
@property (nonatomic) BOOL hiddenWhenStoped;

/**
 进度
 值为0.0f ~ 1.0f
 */
@property (nonatomic) CGFloat value;

@end
