//
//  SSAlertView+SSAdd.m
//  SSKitDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "SSAlertView+SSAdd.h"
#import "UIColor+SSAlertView.h"

@implementation SSAlertView (SSAdd)

+ (SSAlertView *)showCustomizedView:(UIView *)view alsoSize:(CGSize)size {
    SSAlertView *alertView = [[SSAlertView alloc] init];
    alertView.customView = view;
    alertView.customSize = size;
    [alertView show];
    return alertView;
}

+ (SSAlertView *)showAllOpts:(NSArray *)opts callback:(ssav_selectedCallback)callback {
    SSAlertView *view = [[SSAlertView alloc] init];
    view.options = opts;
    view.isAlertViewHiddenCancel = YES;
    view.isAlertViewVertical = YES;
    [view.optAttributes setObject:[UIFont systemFontOfSize:18] forKey:SSAlertViewOptFont];
    [view.optAttributes setObject:[UIColor ssav_hexColor:@"4b4949"] forKey:SSAlertViewOptNormalTextColor];
    [view.optAttributes setObject:[UIColor whiteColor] forKey:SSAlertViewOptNormalBackgroundColor];
    [view.optAttributes setObject:[UIColor ssav_hexColor:@"f5f5f5"] forKey:SSAlertViewOptHighlightBackgroundColor];
    view.optHeight = 62.5f;
    view.optMaxWidth = [UIScreen mainScreen].bounds.size.width - 40;
    view.callback = callback;
    view.isAlertViewTapedClose = YES;
    [view show];
    return view;
}

+ (SSAlertView *)showTitle:(NSString *)title alsoContent:(NSString *)content alsoOpts:(NSArray *)opts callback:(ssav_selectedCallback)callback {
    return [self showTitle:title alsoContent:content alsoOpts:opts isHiddenCancel:NO callback:callback];
}

+ (SSAlertView *)showTitle:(NSString *)title alsoContent:(NSString *)content alsoOpts:(NSArray *)opts isHiddenCancel:(BOOL)isHidden callback:(ssav_selectedCallback)callback {
    return [self showTitle:title alsoContent:content alsoOpts:opts isHiddenCancel:isHidden isAlwaysVisible:NO callback:callback];
}

+ (SSAlertView *)showTitle:(NSString *)title alsoContent:(NSString *)content alsoOpts:(NSArray *)opts isHiddenCancel:(BOOL)isHidden isAlwaysVisible:(BOOL)isAlwaysVisible callback:(ssav_selectedCallback)callback {
    SSAlertView *view = [[SSAlertView alloc] init];
    view.options = opts;
    view.titleLabel.text = title;
    view.contentLabel.text = content;
    view.callback = callback;
    view.isAlertViewHiddenCancel = isHidden;
    view.isAlertViewAlwaysVisible = isAlwaysVisible;
    [view show];
    return view;
}

+ (void)closeAllAlertView {
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[SSAlertView class]]) {
            [(SSAlertView *)view close];
        }
    }
}

@end
