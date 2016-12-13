//
//  UIColor+DTBAdd.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/25.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "UIColor+DTBAdd.h"

@implementation UIColor (DTBAdd)

+ (UIColor *)colorWithRGB:(NSString *)RGBString {
    NSArray *colors = [RGBString componentsSeparatedByString:@","];
    if (!colors || colors.count != 3) return [UIColor whiteColor];
    return [UIColor colorWithRed:[colors[0] floatValue] / 255.0f green:[colors[1] floatValue] / 255.0f blue:[colors[2] floatValue] / 255.0f alpha:1.0f];
}

@end
