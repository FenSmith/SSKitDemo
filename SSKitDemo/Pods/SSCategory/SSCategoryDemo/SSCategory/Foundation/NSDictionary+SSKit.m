//
//  NSDictionary+SSKit.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "NSDictionary+SSKit.h"
#import "NSArray+SSKit.h"

@implementation NSDictionary (SSKit)

- (NSMutableDictionary *)dicMutable {
    return [[NSMutableDictionary alloc] initWithDictionary:self];
}

- (NSString *)dicURLSort {
    if (self.allKeys == 0) {
        return @"";
    }
    
    NSString *str = @"";
    for (NSString *key in [self.allKeys objSort]) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[self objectForKey:key]]];
    }
    return [str substringToIndex:str.length - 1];
}

- (NSDictionary *)dicAppendingParams:(NSDictionary *)params{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self];
    for (NSString *key in params.allKeys) {
        [dic setObject:[params objectForKey:key] forKey:key];
    }
    return dic;
}

@end
