//
//  Test.m
//  Test
//
//  Created by wesley chen on 15/7/24.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSURL+Addition.h"

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

- (void)testMainURL {
    NSURL *url = [NSURL URLWithString:@"http://captcha.360.cn/image.php?app=360licai&rand=24578508771437718641&dlist=100000&nt=WIFI&d=8F057C167279790D31398A7634773EE4&v=1&vn=1.0.0&ov=8.4&source=mpc_pay_licaiios"];
    XCTAssertEqualObjects([url mainURL].absoluteString, @"http://captcha.360.cn/image.php");
}

@end
