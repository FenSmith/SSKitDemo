//
//  NSString+SSAlertView.m
//  SSAlertViewDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "NSString+SSAlertView.h"

@implementation NSString (SSAlertView)

- (CGSize)ssav_stringSizeAttachFont:(UIFont *)font attachMaxSize:(CGSize)size {
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size;
}

@end
