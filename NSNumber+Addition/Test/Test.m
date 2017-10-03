//
//  Test.m
//  Test
//
//  Created by wesley chen on 15/4/11.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSNumber+Addition.h"

@interface Test : XCTestCase

@end

@implementation Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"\n");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    NSLog(@"\n");
}

- (void)testFactorial {
    NSLog(@"0! = %@", [@(0) factorial]);
    NSLog(@"1! = %@", [@(1) factorial]);
    NSLog(@"2! = %@", [@(2) factorial]);
    NSLog(@"3! = %@", [@(3) factorial]);
    NSLog(@"4! = %@", [@(4) factorial]);
    NSLog(@"5! = %@", [@(5) factorial]);
    NSLog(@"6! = %@", [@(6) factorial]);
    NSLog(@"7! = %@", [@(7) factorial]);
    NSLog(@"8! = %@", [@(8) factorial]);
}

@end
