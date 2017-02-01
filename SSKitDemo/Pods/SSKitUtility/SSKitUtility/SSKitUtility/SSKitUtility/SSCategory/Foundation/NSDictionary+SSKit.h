//
//  NSDictionary+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SSKit)

/**
 转换成可变字典
 */
- (NSMutableDictionary *)dicMutable;

/**
 对字典中的键值进行‘类URL’排序
 例如: { 
   a : 111,
   e : 222,
   c : 333,
   b : 444  
 }
 => a=111&b=444&c=333&e=222
 */
- (NSString *)dicURLSort;

/**
 添加另外的字典的数据
 */
- (NSDictionary *)dicAppendingParams:(NSDictionary *)params;

@end
