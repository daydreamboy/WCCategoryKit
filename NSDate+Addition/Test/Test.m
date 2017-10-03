//
//  Test.m
//  Test
//
//  Created by wesley chen on 15/10/21.
//
//

#import <XCTest/XCTest.h>
#import "NSDate+Addition.h"

@interface Test : XCTestCase

@end

@implementation Test

- (void)setUp {
    [super setUp];
    NSLog(@"\n");
}

- (void)tearDown {
    [super tearDown];
    NSLog(@"\n");
}

#pragma mark - Get Date String

- (void)test_StringFromCurrentDate {
    NSLog(@"%@", [NSDate date]);
    NSLog(@"%@", [NSDate stringFromCurrentDate]);
    
    NSString *localDate1 =[[NSDate date] descriptionWithLocale:[NSLocale systemLocale]];
    
    NSLog(@"%@", localDate1);
    
    NSString *localDate = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
    
    NSLog(@"%@", localDate);
}

- (void)test_stringFromCurrentDateWithFormat {
    NSLog(@"%@", [NSDate date]);
    NSLog(@"%@", [NSDate stringFromCurrentDateWithFormat:nil]);
    
    // @see http://stackoverflow.com/questions/25616141/time-format-ios-2014-04-28t010321-827753
    // @see http://stackoverflow.com/a/13942921/4794665
    
    // Usage 1:
    //  timestamp for logging
    NSLog(@"timestamp for logging: %@", [NSDate stringFromCurrentDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'ZZ"]);
    NSLog(@"timestamp for logging: %@", [NSDate stringFromCurrentDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'ZZZZZ"]);
    
    // Usage 2:
    //  timestamp for file name (Use '_' instead of ':', because system not allow ':' in file name.
    //  And '/' is not proper for file name, it's also a separator for path)
    NSLog(@"timestamp for logging: %@", [NSDate stringFromCurrentDateWithFormat:@"yyyy-MM-dd'T'HH_mm_ss.SSS'Z'ZZ"]);
    
    
    // Usage 3:
    //  timestamp conversion between NSString and NSDate
    
    //  NSDate -> NSString
    NSString *format = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'ZZ";
    NSString *dateString = [NSDate stringFromCurrentDateWithFormat:format];
    NSLog(@"dateString: %@", dateString);
    
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = format;
    
    // NSString -> NSDate
    NSDate *date = [dateFomatter dateFromString:dateString];
    NSLog(@"date: %@", date);
    
    // Check
    NSLog(@"dateString (again): %@", [NSDate stringOfLocalTimezoneWithDate:date]);
}

#pragma mark - Date Unit Comparison

- (void)test_sameYearWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *afterAWhile = [NSDate date];
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameYearWithDate:afterAWhile]);
}

- (void)test_sameMonthWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *afterAWhile = [NSDate date];
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameMonthWithDate:afterAWhile]);
}

- (void)test_sameWeekOfYearWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *afterAWhile = [NSDate date];
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameWeekOfYearWithDate:afterAWhile]);
}

- (void)test_sameWeekOfMonthWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *afterAWhile = [NSDate date];
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameWeekOfMonthWithDate:afterAWhile]);
}

#pragma mark

- (void)test_sameDayWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *afterAWhile = [NSDate date];
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameDayWithDate:afterAWhile]);
}

- (void)test_sameWeekdayWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *afterAWhile = [NSDate date];
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameWeekdayWithDate:afterAWhile]);
}

#pragma mark -

- (void)test_sameHourWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *afterAWhile = [NSDate date];
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameHourWithDate:afterAWhile]);
}

- (void)test_sameMinuteWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *afterAWhile = [NSDate date];
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameMinuteWithDate:afterAWhile]);
}

- (void)test_sameSecondWithDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@", now);
    [NSThread sleepForTimeInterval:10];
    
    NSDate *now2 = [now copy];
    NSDate *afterAWhile = [NSDate date];
    
    NSLog(@"%@", now2);
    NSLog(@"%@", afterAWhile);
    
    XCTAssertTrue([now sameSecondWithDate:now2]);
    XCTAssertFalse([now sameSecondWithDate:afterAWhile]);
}

#pragma mark - Components of Date

- (void)test_propertiesOfDate {
    NSDate *now = [NSDate date];
    
    NSLog(@"%@\n", now);
    
    NSLog(@"%ld, %ld, %ld, %ld, %ld, %ld, %ld, %ld, %ld\n",
          now.year,
          now.month,
          now.weekOfYear,
          now.weekOfMonth,
          now.day,
          now.weekday,
          now.hour,
          now.minute,
          now.second
          );
}

@end
