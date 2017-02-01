//
//  NSDate+SSKit.h
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,SSDateType) {
    SSDateTypeSecond  = 0,
    SSDateTypeMinute = 1,
    SSDateTypeHour    = 2,
    SSDateTypeDay     = 3,
    SSDateTypeMonth   = 4,
    SSDateTypeYear    = 5,
};

typedef NS_ENUM(NSUInteger,SSDateFormatType) {
    SSDateFormatTypeYMD   = 0,
    SSDateFormatTypeHm    = 1,
    SSDateFormatTypeYMDHm = 2,
    SSDateFormatTypeMD    = 3,
};

@interface NSDate (SSKit)

/**
 获取时间的某个部分
 */
- (NSDateComponents *)components;

/**
 获取星期几(中文)
 周日 周一 周二 周三 周四 周五 周六
  1   2    3   4   5    6   7
 */
- (NSString *)dateWeekStringChinese;

/**
 根据值获取对应的间隔时间
 
 [NSDate date] => 2016.09.12 12:00 => dateType = SSDateTypeHour & values = 2
 result => 2016.09.12 14:00
 */
- (NSDate *)dateOffsetWithType:(SSDateType)dateType alsoValues:(NSInteger)values;

/**
 根据类型获得对应的时间文本
 */
- (NSString *)dateStringWithFormatType:(SSDateFormatType)dateType;
- (NSString *)dateStringWithFormat:(NSString *)format;

/**
 根据时间文本获取时间
 */
+ (NSDate *)dateFromString:(NSString *)string alsoType:(NSString *)type;

+ (NSDate *)dateYesterday;
+ (NSDate *)dateTomorrow;

- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;

/**
 是否这个两个时间的对应部分相同
 */
+ (BOOL)dateIsEqualWithDate1:(NSDate *)date1 alsoDate2:(NSDate *)date2 alsoUnits:(unsigned)units;

/**
 当前时间是否与对应时间相同
 有且只比较年、月、日
 */
- (BOOL)dateIsEqual:(NSDate *)aDate;
- (BOOL)dateMonthIsEqual:(NSDate *)aDate;

/**
 获取当前时间的截止到当天的所有秒数
 2016-01-01 23:59:59
 */
- (NSDate *)dateAddAllDayTimeInterval;

/**
 获取当前时间的当天的初始秒数
 2016-01-01 00:00:00
 */
- (NSDate *)dateFromAllDayTimeInterval;

/**
 获取这个月的第一个天的时间
 */
- (NSDate *)dateFirstDayInMonth;

/**
 获取这个月的最后一天的最后一秒时间
 */
- (NSDate *)dateFinalDayInMonth;

/**
 获取这个月总共有几天
 */
- (NSInteger)dateDaysInMonth;

/**
 根据Unit获取时间1与时间2的差值
 例: 
     date1 : 2016-07-01
     date2 : 2016-07-02
 =>  components -> 0  //应该返回1
 
     date1 : 2016-07-02
     date2 : 2016-07-01
 =>  components -> -1
 */
+ (NSInteger)dateDifferenceInDate1:(NSDate *)date1 alsoDate2:(NSDate *)date2 alsoUnit:(NSCalendarUnit)unit;

@end
