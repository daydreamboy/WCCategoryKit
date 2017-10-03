//
//  NSDate+Addition.h
//  NSDate+Addition
//
//  Created by wesley chen on 15/10/21.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, NSWeekday) {
    NSWeekdaySunday = 1,
    NSWeekdayMonday = 2,
    NSWeekdayTuesday = 3,
    NSWeekdayWednesday = 4,
    NSWeekdayThursday = 5,
    NSWeekdayFriday = 6,
    NSWeekdaySaturday = 7,
};

@interface NSDate (Addition)

#pragma mark - Get Date String

+ (NSString *)stringFromCurrentDate;
+ (NSString *)stringFromCurrentDateWithFormat:(NSString *)format;
+ (NSString *)stringOfLocalTimezoneWithDate:(NSDate *)date;

#pragma mark - Components of Date (without time zone)

@property (readonly) NSInteger year;
@property (readonly) NSInteger month;

@property (readonly) NSInteger weekOfYear;
@property (readonly) NSInteger weekOfMonth;

@property (readonly) NSInteger day;
@property (readonly) NSWeekday weekday;

@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger second;

@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2

#pragma mark
#pragma mark Date Unit Comparison

- (BOOL)sameYearWithDate:(NSDate *)date;
- (BOOL)sameMonthWithDate:(NSDate *)date;
- (BOOL)sameWeekOfYearWithDate:(NSDate *)date;
- (BOOL)sameWeekOfMonthWithDate:(NSDate *)date;

- (BOOL)sameDayWithDate:(NSDate *)date;
- (BOOL)sameWeekdayWithDate:(NSDate *)date;

- (BOOL)sameHourWithDate:(NSDate *)date;
- (BOOL)sameMinuteWithDate:(NSDate *)date;
- (BOOL)sameSecondWithDate:(NSDate *)date;

#pragma mark Adjust Date

- (NSDate *)dateByAddingYears:(NSInteger)dYears;
- (NSDate *)dateBySubtractingYears:(NSInteger)dYears;
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths;
- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSInteger)dHours;
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;

@end
