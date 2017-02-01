//
//  UITextField+SSKit.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "UITextField+SSKit.h"

@implementation UITextField (SSKit)

+ (UITextField *)textFieldAddLeftViewPadding:(CGFloat)padding {
    UITextField *textField = [[UITextField alloc] init];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

@end
