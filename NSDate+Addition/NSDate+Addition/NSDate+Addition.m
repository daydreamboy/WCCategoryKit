//
//  NSDate+Addition.m
//  NSDate+Addition
//
//  Created by wesley chen on 15/10/21.
//
//

#import "NSDate+Addition.h"
#import <UIKit/UIKit.h>

@implementation NSDate (Addition)

#pragma mark - Components of date

//- (NSInteger)nearestHour {
//    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
//    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
//    NSDateComponents *components = [[NSDate currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
//
//    return components.hour;
//}

- (NSInteger)year {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.year;
}

- (NSInteger)month {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.month;
}

- (NSInteger)weekOfYear {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.weekOfYear;
}

- (NSInteger)weekOfMonth {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.weekOfMonth;
}

- (NSInteger)day {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.day;
}

- (NSWeekday)weekday {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.weekday;
}

- (NSInteger)hour {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.hour;
}

- (NSInteger)minute {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.minute;
}

- (NSInteger)second {
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];
    
    return components.second;
}

- (NSInteger)nthWeekday  // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:[NSDate componentFlags] fromDate:self];

    return components.weekdayOrdinal;
}

#pragma mark - 

/**
 *  Get date with GMT time zone
 *
 *  @warning date and time part of the return date is correct, but timezone is always +0000, 
 *           so the return date should be avoided to use it when need timezone or convert between timezones
 *
 *  @sa http://stackoverflow.com/questions/4547379/nsdate-is-not-returning-my-local-time-zone-default-time-zone-of-device
 *  @return the current date
 */
+ (NSDate *)dateWithLocalTimeZone __attribute__((deprecated)) {
    NSDate *sourceDate = [NSDate date];

    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];

    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;

    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];

    return destinationDate;
}

/**
 *  Get the string of date with system timezone, e.g. 2015-10-29 00:19:46 +0000
 *
 *  @return the string of local date
 */
+ (NSString *)stringFromCurrentDate {
    static NSDateFormatter *sDateFormatter;
    if (!sDateFormatter) {
        sDateFormatter = [[NSDateFormatter alloc] init];
        sDateFormatter.timeZone = [NSTimeZone systemTimeZone];
        sDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZ";
    }
    
    return [sDateFormatter stringFromDate:[NSDate date]];
}

/**
 *  Get the string of date with system timezone, and show with custom format, e.g.
 *
 *  @return the string of local date
 */
+ (NSString *)stringFromCurrentDateWithFormat:(NSString *)format {
    static NSDateFormatter *sDateFormatter;
    if (!sDateFormatter) {
        sDateFormatter = [[NSDateFormatter alloc] init];
        sDateFormatter.timeZone = [NSTimeZone systemTimeZone];
    }
    if (!format.length) {
        format = @"yyyy-MM-dd HH:mm:ss ZZ";
    }
    
    sDateFormatter.dateFormat = format;
    
    return [sDateFormatter stringFromDate:[NSDate date]];
}

/**
 *  Convert date into string with system timezone
 *
 *  @return the date string
 */
+ (NSString *)stringOfLocalTimezoneWithDate:(NSDate *)date {
    static NSDateFormatter *sDateFormatter;
    if (!sDateFormatter) {
        sDateFormatter = [[NSDateFormatter alloc] init];
        sDateFormatter.timeZone = [NSTimeZone systemTimeZone];
        sDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZ";
    }
    
    return [sDateFormatter stringFromDate:date];
}

#pragma mark - Date Comparison

- (BOOL)sameYearWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:equalToDate:toUnitGranularity:)]) {
        // NSCalendarUnitYear in iOS 7+
        return [currentCalentdar isDate:date equalToDate:self toUnitGranularity:NSCalendarUnitYear];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];
        
        return comp1.year == comp2.year;
    }
}

- (BOOL)sameMonthWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:equalToDate:toUnitGranularity:)]) {
        // NSCalendarUnitMonth in iOS 7+
        return [currentCalentdar isDate:date equalToDate:self toUnitGranularity:NSCalendarUnitMonth];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];
        
        return comp1.month == comp2.month;
    }
}

- (BOOL)sameWeekOfMonthWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:equalToDate:toUnitGranularity:)]) {
        // NSCalendarUnitYear in iOS 7+
        return [currentCalentdar isDate:date equalToDate:self toUnitGranularity:NSCalendarUnitWeekOfMonth];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];
        
        return comp1.weekOfMonth == comp2.weekOfMonth;
    }
}

- (BOOL)sameWeekOfYearWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:equalToDate:toUnitGranularity:)]) {
        // NSCalendarUnitYear in iOS 7+
        return [currentCalentdar isDate:date equalToDate:self toUnitGranularity:NSCalendarUnitWeekOfYear];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];
        
        return comp1.weekOfYear == comp2.weekOfYear;
    }
}

- (BOOL)sameDayWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:inSameDayAsDate:)]) {

        return [currentCalentdar isDate:date inSameDayAsDate:self];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];

        return comp1.day == comp2.day
               && comp1.month == comp2.month
               && comp1.year == comp2.year;
    }
}

- (BOOL)sameWeekdayWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:equalToDate:toUnitGranularity:)]) {
        // NSCalendarUnitWeekday in iOS 7+
        return [currentCalentdar isDate:date equalToDate:self toUnitGranularity:NSCalendarUnitWeekday];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];

        return comp1.weekday == comp2.weekday;
    }
}

- (BOOL)sameHourWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:equalToDate:toUnitGranularity:)]) {
        // NSCalendarUnitHour in iOS 7+
        return [currentCalentdar isDate:date equalToDate:self toUnitGranularity:NSCalendarUnitHour];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];
        
        return comp1.hour == comp2.hour;
    }
}

- (BOOL)sameMinuteWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:equalToDate:toUnitGranularity:)]) {
        // NSCalendarUnitMinute in iOS 7+
        return [currentCalentdar isDate:date equalToDate:self toUnitGranularity:NSCalendarUnitMinute];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];
        
        return comp1.minute == comp2.minute;
    }
}

- (BOOL)sameSecondWithDate:(NSDate *)date {
    NSCalendar *currentCalentdar = [[self class] currentCalendar];
    
    // iOS 8+
    if ([NSCalendar instancesRespondToSelector:@selector(isDate:equalToDate:toUnitGranularity:)]) {
        // NSCalendarUnitSecond in iOS 7+
        return [currentCalentdar isDate:date equalToDate:self toUnitGranularity:NSCalendarUnitSecond];
    }
    // iOS 7-
    else {
        NSDateComponents *comp1 = [currentCalentdar components:[NSDate componentFlags] fromDate:self];
        NSDateComponents *comp2 = [currentCalentdar components:[NSDate componentFlags] fromDate:date];
        
        return comp1.second == comp2.second;
    }
}

#pragma mark - Adjust Dates

//- (NSDate *)dateByAddingYears:(NSInteger)dYears {
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//
//    [dateComponents setYear:dYears];
//    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
//    return newDate;
//}
//
//- (NSDate *)dateBySubtractingYears:(NSInteger)dYears {
//    return [self dateByAddingYears:-dYears];
//}
//
//- (NSDate *)dateByAddingMonths:(NSInteger)dMonths {
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//
//    [dateComponents setMonth:dMonths];
//    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
//    return newDate;
//}
//
//- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths {
//    return [self dateByAddingMonths:-dMonths];
//}
//
//// Courtesy of dedan who mentions issues with Daylight Savings
//- (NSDate *)dateByAddingDays:(NSInteger)dDays {
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//
//    [dateComponents setDay:dDays];
//    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
//    return newDate;
//}
//
//- (NSDate *)dateBySubtractingDays:(NSInteger)dDays {
//    return [self dateByAddingDays:(dDays * -1)];
//}
//
//- (NSDate *)dateByAddingHours:(NSInteger)dHours {
//    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
//    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
//
//    return newDate;
//}
//
//- (NSDate *)dateBySubtractingHours:(NSInteger)dHours {
//    return [self dateByAddingHours:(dHours * -1)];
//}
//
//- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes {
//    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
//    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
//
//    return newDate;
//}
//
//- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes {
//    return [self dateByAddingMinutes:(dMinutes * -1)];
//}
//
//- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate {
//    NSDateComponents *dTime = [[NSDate currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
//
//    return dTime;
//}

#pragma mark - Internal

+ (NSCalendar *)currentCalendar {
    static dispatch_once_t pred;
    static __strong NSCalendar *sharedCalendar = nil;

    dispatch_once(&pred, ^{
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    });

    return sharedCalendar;
}

#ifndef SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#endif

/**
 *  Get all compoents of NSDate
 *
 *  @sa http://stackoverflow.com/questions/25952532/weekofyear-not-working
 *  @note must pass the correct flags to the components:fromDate: method
 *
 *  @return all components of NSDate
 */
+ (unsigned)componentFlags {
    
    static unsigned componentFlags;
    
    if (!componentFlags) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            componentFlags = (NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitQuarter  | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear);
        }
        else {
            // Contants deprecated in iOS 8+
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
            componentFlags = (NSEraCalendarUnit | NSYearCalendarUnit| NSMonthCalendarUnit  | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit |
                              NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSQuarterCalendarUnit | NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit);
#pragma GCC diagnostic pop
        }
    }
    
    return componentFlags;
}

+ (NSDate *)UTCDateFromDate:(NSDate *)date {
    
    static NSDateFormatter *dateFormatter;
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return [dateFormatter dateFromString:dateString];
}

@end
