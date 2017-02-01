//
//  SSStarReloadView.h
//  SSPullRefreshDemo
//
//  Created by Quincy Yan on 2017/1/3.
//  Copyright © 2017年 SSKit. All rights reserved.
//

#import "SSReloadBaseView.h"

typedef NS_ENUM(NSInteger,SSStarPosition) {
    SSStarPositionLeft = 0, // 默认
    SSStarPositionCenter = 1,
    SSStarPositionRight = 2,
};

@interface SSStarReloadView : SSReloadBaseView

// 星星控件的位置
@property (nonatomic,assign) SSStarPosition position;

// 对于标准‘Position’的位置的偏差程度,默认为(0,0)
@property (nonatomic) CGPoint pOffset;

@property (nonatomic,assign) CGFloat scale; // 星星缩放大小,默认0.5f
@property (nonatomic,assign) CGFloat lineWidth; // 星星线段大小,默认为2.0f

@property (nonatomic,strong) UIColor *starStrokeColor; // 星星线段填充颜色,默认为242,202,72
@property (nonatomic,strong) UIColor *starFillColor; // 星星内部填充颜色,默认为242,202,72

@end
