//
//  SSAlertView+SSAdd.h
//  SSKitDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "SSAlertView.h"

@interface SSAlertView (SSAdd)

+ (SSAlertView *)showAlertViewWithOptions:(NSArray *)opts withCallback:(ssav_selectedCallback)callback;

+ (SSAlertView *)showAlertViewWithTitle:(NSString *)title
                            withContent:(NSString *)content
                             withOptions:(NSArray *)opts
                           withCallback:(ssav_selectedCallback)callback;

+ (SSAlertView *)showAlertViewWithTitle:(NSString *)title
                            withContent:(NSString *)content
                             withOptions:(NSArray *)opts
                   isHiddenCancelOption:(BOOL)isHiddenCancelOption
                           withCallback:(ssav_selectedCallback)callback;

+ (SSAlertView *)showAlertViewWithTitle:(NSString *)title
                            withContent:(NSString *)content
                             withOptions:(NSArray *)opts
                   isHiddenCancelOption:(BOOL)isHiddenCancelOption
                        isAlwaysVisible:(BOOL)isAlwaysVisible
                           withCallback:(ssav_selectedCallback)callback;

+ (SSAlertView *)showCustomizedView:(UIView *)view alsoSize:(CGSize)size;

+ (void)closeAllAlertView;

@end
