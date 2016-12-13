//
//  UIImageView+DTBAdd.m
//  DotaBox-iOS
//
//  Created by QuincyYan on 16/10/31.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "UIImageView+DTBAdd.h"

@implementation UIImageView (DTBAdd)

+ (UIImageView *)avatorViewAttachCornerRadius:(CGFloat)cornerRadius {
    UIImageView *view = [[UIImageView alloc] init];
    [view viewAddCornerRadius:cornerRadius];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

@end
