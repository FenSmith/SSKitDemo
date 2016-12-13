//
//  UIImageView+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SSKit)

+ (UIImageView *)imageViewAddImageName:(NSString *)imageName;
+ (UIImageView *)imageViewAddScaleToFillType;

+ (UIImageView *)avatorViewAttachCornerRadius:(CGFloat)cornerRadius;

@end
