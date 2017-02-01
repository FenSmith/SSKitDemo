//
//  NSString+SSTabbarWrapper.m
//  SSWrapper
//
//  Created by Quincy Yan on 2017/1/31.
//  Copyright © 2017年 Quincy Yan. All rights reserved.
//

#import "NSString+SSTabbarWrapper.h"

@implementation NSString (SSTabbarWrapper)

- (CGSize)sstw_stringSizeAttachFont:(UIFont *)font attachMaxSize:(CGSize)size {
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size;
}

@end
