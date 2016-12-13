//
//  SSBarEntity.h
//  SSKit
//
//  Created by Quincy Yan on 16/5/24.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSBarEntity : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *helImage;

@property (nonatomic,strong) UIButton *entityButton;
// 如果有该属性,则直接返回该尺寸不进行计算
@property (nonatomic) CGSize buttonSize;

// 自设定的图片尺寸
@property (nonatomic) CGSize imageSize;

@property (nonatomic) NSInteger badgeValue;

- (CGSize)sizeForEntity;
- (void)resetNetworkImage:(NSString *)image alsoPlaceHolderImage:(UIImage *)placeHolder;

+ (SSBarEntity *)entityContainsTitle:(NSString *)title;
+ (SSBarEntity *)entityContainsImage:(UIImage *)image;
+ (SSBarEntity *)entityContainsImage:(NSString *)image alsoScale:(CGFloat)scale;
+ (SSBarEntity *)entityContainsImage:(UIImage *)image alsoTitle:(NSString *)title;

+ (SSBarEntity *)entityContainsImage:(UIImage *)image highlightImage:(UIImage *)helImage;
+ (SSBarEntity *)entityContainsImage:(NSString *)image highlightImage:(NSString *)helImage alsoScale:(CGFloat)scale;
+ (SSBarEntity *)entityContainsImage:(UIImage *)image highlightImage:(UIImage *)helImage alsoTitle:(NSString *)title;

@end
