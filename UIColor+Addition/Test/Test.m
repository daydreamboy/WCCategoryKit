//
//  Test.m
//  Test
//
//  Created by wesley chen on 16/4/13.
//
//

#import <XCTest/XCTest.h>
#import "UIColor+Addition.h"

@interface Test : XCTestCase

@end

@implementation Test

- (void)setUp {
    [super setUp];
    NSLog(@"\n");
}

- (void)tearDown {
    NSLog(@"\n");
    [super tearDown];
}

- (void)test_colorWithRGBAString {
    UIColor *color;
    
    // Case 1: RGBA string -> UIColor
    color = [UIColor colorWithHexString:@"#FF0000FF"];
    XCTAssertEqualObjects([UIColor RGBAHexStringWithColor:color], @"#FF0000FF");
    
    color = [UIColor colorWithHexString:@"#00FF00FF"];
    NSLog(@"%@", [UIColor RGBAHexStringWithColor:color]);
    
    color = [UIColor colorWithHexString:@"#0000FFFF"];
    NSLog(@"%@", [UIColor RGBAHexStringWithColor:color]);
    
    // Abnormal Case 1: parse error
    color = [UIColor colorWithHexString:@"#ZZ0000"];
    XCTAssertNil(color);
    
    // Abnormal Case 2: parse error
    color = [UIColor colorWithHexString:@"##F00FF00"];
    XCTAssertNil(color);
    
    // Abnormal Case 3: uncorrect length
    color = [UIColor colorWithHexString:@"#FFFF"];
    XCTAssertNil(color);
    
    // Abnormal Case 4: format error (has no `#` prefix)
    color = [UIColor colorWithHexString:@"FF00FF"];
    XCTAssertNil(color);
}

@end
