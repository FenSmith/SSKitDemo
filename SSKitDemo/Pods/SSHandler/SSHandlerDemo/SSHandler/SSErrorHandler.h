//
//  SSErrorHandler.h
//  SSKit
//
//  Created by Quincy Yan on 16/1/1.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSErrorHandler : NSObject

//---------------------------------------
// 默认显示Error字段:error.userInfo[@"msg"]
//---------------------------------------
+ (void)errorHandlerWithError:(NSError *)error showInView:(UIView *)inView;
+ (void)errorHandlerWithError:(NSError *)error msg:(NSString *)msg showInView:(UIView *)inView;
+ (void)errorHandlerWithError:(NSError *)error;
+ (void)errorHandlerWithError:(NSError *)error msg:(NSString *)msg;

+ (BOOL)isNetworkError:(NSError *)error;

@end
