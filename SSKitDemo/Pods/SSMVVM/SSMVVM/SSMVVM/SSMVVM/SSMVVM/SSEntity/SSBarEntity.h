//
//  SSBarEntity.h
//  SSKit
//
//  Created by Quincy Yan on 16/5/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSBarEntity : UIView

@property (nonatomic,strong) UIButton *internalButton;

@property (nonatomic,copy) NSString *title;

/**
 原本需要根据title与image进行控件长度计算
 设定了entitySize后就直接返回该值
 */
@property (nonatomic,assign) CGSize entitySize;
@property (nonatomic,assign) CGSize imageSize;
@property (nonatomic,assign) NSInteger badgeValue;

- (void)setImage:(UIImage *)image forState:(UIControlState)state;
- (void)setImage:(NSString *)image withPlaceHolderImage:(UIImage *)placeHolderImage forState:(UIControlState)state;
- (CGSize)calculateSizeForEntity;

+ (SSBarEntity *)setupEntityWithTitle:(NSString *)title;
+ (SSBarEntity *)setupEntityWithNormalImage:(UIImage *)image;
+ (SSBarEntity *)setupEntityWithNormalImage:(UIImage *)image withTitle:(NSString *)title;
+ (SSBarEntity *)setupEntityWithNormalImage:(UIImage *)image withHighlightImage:(UIImage *)highlightImage;

@end
