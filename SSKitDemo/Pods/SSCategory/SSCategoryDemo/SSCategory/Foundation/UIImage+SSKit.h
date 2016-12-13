//
//  UIImage+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SSKit)

- (UIImage *)imageScale:(CGFloat)scale;

+ (UIImage *)imageScreenShotUsingContext:(BOOL)useContext;

- (UIImage *)imageRotateWithDegrees:(CGFloat)degrees;

+ (UIImage *)imageContentName:(NSString *)name;
+ (UIImage *)imageContentName:(NSString *)name alsoType:(NSString *)type;

@end
