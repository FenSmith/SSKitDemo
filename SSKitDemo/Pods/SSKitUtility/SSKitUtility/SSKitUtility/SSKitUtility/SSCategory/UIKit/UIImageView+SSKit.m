//
//  UIImageView+SSKit.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UIImageView+SSKit.h"
#import "UIView+SSKit.h"

@implementation UIImageView (SSKit)

+ (UIImageView *)imageViewAddImageName:(NSString *)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

+ (UIImageView *)imageViewAddScaleToFillType {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

+ (UIImageView *)avatorViewAttachCornerRadius:(CGFloat)cornerRadius {
    UIImageView *view = [[UIImageView alloc] init];
    [view viewAddCornerRadius:cornerRadius];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

@end
