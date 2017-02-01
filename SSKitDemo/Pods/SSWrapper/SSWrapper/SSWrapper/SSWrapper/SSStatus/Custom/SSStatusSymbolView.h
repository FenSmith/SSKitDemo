//
//  SSStatusTypeView.h
//  SSStatusDemo
//
//  Created by Quincy Yan on 2017/1/27.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSStatusBaseView.h"

@interface SSStatusSymbolView : SSStatusBaseView

@property (nonatomic,assign) SSStatusViewType type;

/**
 symbol的填充颜色
 默认为红色
 */
@property (nonatomic,strong) UIColor *strokeColor;

/**
 描线的宽度
 默认为3.0f
 */
@property (nonatomic,assign) CGFloat strokeLineWidth;

/**
 symbol视图的大小
 默认为25 * 25
 */
@property (nonatomic) CGSize symbolViewSize;

- (void)statusSymbolViewReadyToAnimation;

@end
