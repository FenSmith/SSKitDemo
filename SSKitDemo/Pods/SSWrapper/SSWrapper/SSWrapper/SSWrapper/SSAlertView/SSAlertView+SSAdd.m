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

+ (SSAlertView *)showAlertViewWithOptions:(NSArray *)opts withCallback:(ssav_selectedCallback)callback {
    SSAlertView *view = [[SSAlertView alloc] init];
    view.options = opts;
    view.isAlertViewHiddenCancel = YES;
    view.isAlertViewVertical = YES;
    [view.optAttributes setObject:[UIFont systemFontOfSize:18] forKey:SSAlertViewOptFont];
    [view.optAttributes setObject:[UIColor ssav_hexColor:@"4b4949"] forKey:SSAlertViewOptNormalTextColor];
    [view.optAttributes setObject:[UIColor whiteColor] forKey:SSAlertViewOptNormalBackgroundColor];
    [view.optAttributes setObject:[UIColor ssav_hexColor:@"f5f5f5"] forKey:SSAlertViewOptHighlightBackgroundColor];
    view.callback = callback;
    view.isAlertViewTapToClose = YES;
    [view show];
    return view;
}

+ (SSAlertView *)showAlertViewWithTitle:(NSString *)title withContent:(NSString *)content withOptions:(NSArray *)opts withCallback:(ssav_selectedCallback)callback {
    return [self showAlertViewWithTitle:title withContent:content withOptions:opts isHiddenCancelOption:NO withCallback:callback];
}

+ (SSAlertView *)showAlertViewWithTitle:(NSString *)title
                            withContent:(NSString *)content
                            withOptions:(NSArray *)opts
                   isHiddenCancelOption:(BOOL)isHiddenCancelOption
                           withCallback:(ssav_selectedCallback)callback {
    return [self showAlertViewWithTitle:title withContent:content withOptions:opts isHiddenCancelOption:isHiddenCancelOption isAlwaysVisible:NO withCallback:callback];
}

+ (SSAlertView *)showAlertViewWithTitle:(NSString *)title
                            withContent:(NSString *)content
                            withOptions:(NSArray *)opts
                   isHiddenCancelOption:(BOOL)isHiddenCancelOption
                        isAlwaysVisible:(BOOL)isAlwaysVisible
                           withCallback:(ssav_selectedCallback)callback {
    SSAlertView *view = [[SSAlertView alloc] init];
    view.options = opts;
    view.titleLabel.text = title;
    view.contentLabel.text = content;
    view.callback = callback;
    view.isAlertViewHiddenCancel = isHiddenCancelOption;
    view.isAlertViewAlwaysVisible = isAlwaysVisible;
    [view show];
    return view;
}

+ (SSAlertView *)showCustomizedView:(UIView *)view alsoSize:(CGSize)size {
    SSAlertView *alertView = [[SSAlertView alloc] init];
    alertView.customView = view;
    alertView.customSize = size;
    [alertView show];
    return alertView;
}

+ (void)closeAllAlertView {
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[SSAlertView class]]) {
            [(SSAlertView *)view close];
        }
    }
}

@end
