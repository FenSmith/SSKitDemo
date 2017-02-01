//
//  NSObject+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SSKit)

/**
 拨打电话
 */
+ (void)objCall:(NSString *)number;

/**
 打开一个网页链接
 */
+ (void)objOpenURL:(NSString *)URL;

/**
 跳转系统协议
 */
+ (void)objOpenSystemURL:(NSString *)URL;

/**
 获取当前设备型号
 */
+ (NSString *)objDeviceType;

/**
 获取对外版本号
 */
+ (NSString *)objShortVersion;

/**
 获取包名
 */
+ (NSString *)objBundleIdentifier;

/**
 获取UUID
 */
+ (NSString *)objUUID;

@end
