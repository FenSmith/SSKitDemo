//
//  SSAlertView+SSAdd.h
//  SSKitDemo
//
//  Created by QuincyYan on 16/11/2.
//  Copyright © 2016年 Quincy Yan. All rights reserved.
//

#import "SSAlertView.h"

@interface SSAlertView (SSAdd)

+ (SSAlertView *)showAllOpts:(NSArray *)opts callback:(ssav_selectedCallback)callback;
+ (SSAlertView *)showTitle:(NSString *)title alsoContent:(NSString *)content alsoOpts:(NSArray *)opts callback:(ssav_selectedCallback)callback;
+ (SSAlertView *)showTitle:(NSString *)title alsoContent:(NSString *)content alsoOpts:(NSArray *)opts isHiddenCancel:(BOOL)isHidden callback:(ssav_selectedCallback)callback;
+ (SSAlertView *)showTitle:(NSString *)title alsoContent:(NSString *)content alsoOpts:(NSArray *)opts isHiddenCancel:(BOOL)isHidden isAlwaysVisible:(BOOL)isAlwaysVisible callback:(ssav_selectedCallback)callback;
+ (SSAlertView *)showCustomizedView:(UIView *)view alsoSize:(CGSize)size;

+ (void)closeAllAlertView;

@end
