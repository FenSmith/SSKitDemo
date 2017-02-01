//
//  SSPageControl.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/27.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SSPageControlType) {
    SSPageControlTypeCircle = 0,
    SSPageControlTypeRect = 1,
};

@interface SSPageControl : UIView

@property (nonatomic) SSPageControlType type;

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger numbersOfPages;

@property (nonatomic,strong) UIColor *currentPageIndicatorColor;
@property (nonatomic,strong) UIColor *othersPageIndicatorColor;

@property (nonatomic) CGSize sizeForPageIndicator;
@property (nonatomic) CGFloat pageItemPadding;

@end
