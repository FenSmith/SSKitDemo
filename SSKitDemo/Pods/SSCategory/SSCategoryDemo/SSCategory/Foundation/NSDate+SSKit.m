//
//  NSDate+SSKit.m
//  SSKit
//
//  Created by Quincy Yan on 16/7/11.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "NSDate+SSKit.h"

static const unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);

@implementation NSDate (SSKit)

- (NSDateComponents *)components{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:componentFlags fromDate:self];
}

- (NSString *)dateWeekStringChinese {
    NSArray *week = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekend = [calendar component:NSCalendarUnitWeekday fromDate:self];
    return week[weekend - 1];
}

- (NSDate *)dateOffsetWithType:(SSDateType)dateType alsoValues:(NSInteger)values {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    switch (dateType) {
        case SSDateTypeSecond:{
            [dateComponents setSecond:values];
        }
            break;
        case SSDateTypeMinute:{
            [dateComponents setMinute:values];
        }
            break;
        case SSDateTypeHour:{
            [dateComponents setHour:values];
        }
            break;
        case SSDateTypeDay:{
            [dateComponents setDay:values];
        }
            break;
        case SSDateTypeMonth:{
            [dateComponents setMonth:values];
        }
            break;
        case SSDateTypeYear:{
            [dateComponents setYear:values];
        }
            break;
        default:
            break;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

+ (NSDate *)dateYesterday {
    return [[NSDate date] dateOffsetWithType:SSDateTypeDay alsoValues:-1];
}

+ (NSDate *)dateTomorrow {
    return [[NSDate date] dateOffsetWithType:SSDateTypeDay alsoValues:1];
}

- (NSString *)dateStringWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)dateStringWithFormatType:(SSDateFormatType)dateType {
    switch (dateType) {
        case SSDateFormatTypeHm:{
            return [self dateStringWithFormat:@"HH:mm"];
        }
            break;
        case SSDateFormatTypeMD:{
            return [self dateStringWithFormat:@"MM-dd"];
        }
            break;
        case SSDateFormatTypeYMD:{
            return [self dateStringWithFormat:@"YYYY-MM-dd"];
        }
            break;
        case SSDateFormatTypeYMDHm:{
            return [self dateStringWithFormat:@"YYYY-MM-dd HH:mm"];
        }
            break;
            
        default:
            break;
    }
    return @"";
}

+ (NSDate *)dateFromString:(NSString *)string alsoType:(NSString *)type {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = type;
    return [formatter dateFromString:string];
}

+ (BOOL)dateIsEqualWithDate1:(NSDate *)date1 alsoDate2:(NSDate *)date2 alsoUnits:(unsigned)units {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:units fromDate:date1];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:units fromDate:date2];

    NSArray *flags = @[@(NSCalendarUnitDay),@(NSCalendarUnitMonth),@(NSCalendarUnitYear)];
    for (int i = 0; i < flags.count; i++) {
        unsigned int flag = [flags[i] intValue];
        if ((units & flag) == flag) {
            if ([components1 valueForComponent:flag] != [components2 valueForComponent:flag]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)dateIsEqual:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)dateMonthIsEqual:(NSDate *)aDate {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month));
}

- (BOOL)isToday {
    return [self dateIsEqual:[NSDate date]];
}

- (BOOL)isTomorrow {
    return [self dateIsEqual:[[NSDate date] dateOffsetWithType:SSDateTypeDay alsoValues:1]];
}

- (BOOL)isYesterday {
    return [self dateIsEqual:[[NSDate date] dateOffsetWithType:SSDateTypeDay alsoValues:-1]];
}

- (NSDate *)dateAddAllDayTimeInterval {
    NSString *dateFormatter = [[self dateOffsetWithType:SSDateTypeDay alsoValues:1] dateStringWithFormatType:SSDateFormatTypeYMD];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSDate *date = [formatter dateFromString:dateFormatter];
    return [NSDate dateWithTimeIntervalSince1970:date.timeIntervalSince1970 - 1];
}

- (NSDate *)dateFromAllDayTimeInterval {
    NSString *dateFormatter = [self dateStringWithFormatType:SSDateFormatTypeYMD];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    return [formatter dateFromString:dateFormatter];
}

- (NSDate *)dateFirstDayInMonth {
    NSString *thisMonth = [[self dateStringWithFormat:@"YYYY-MM"] stringByAppendingString:@"-01"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    return [formatter dateFromString:thisMonth];
}

- (NSDate *)dateFinalDayInMonth {
    NSDate *firstDate = [self dateFirstDayInMonth];
    NSInteger days = [self dateDaysInMonth];
    return [[firstDate dateOffsetWithType:SSDateTypeDay alsoValues:days - 1] dateAddAllDayTimeInterval];
}

- (NSInteger)dateDaysInMonth {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange days = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return days.length;
}

+ (NSInteger)dateDifferenceInDate1:(NSDate *)date1 alsoDate2:(NSDate *)date2 alsoUnit:(NSCalendarUnit)unit {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unit fromDate:date1 toDate:date2 options:0];
    if (comps == 0 && !([date1 dateIsEqual:date2])) {
        return [comps valueForComponent:unit] + 1;
    }
    return [comps valueForComponent:unit];
}

@end
