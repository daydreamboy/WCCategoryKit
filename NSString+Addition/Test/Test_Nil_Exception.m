//
//  Test_Nil_Exception.m
//  NSString+Addition
//
//  Created by wesley chen on 16/7/20.
//
//

#import <XCTest/XCTest.h>

static id nilObject = nil;

@interface Test_Nil_Exception : XCTestCase

@end

@implementation Test_Nil_Exception

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_NSString_APIs {
    /*
    @try {
        NSMutableString *stringM = [[NSMutableString alloc] initWithString:nilObject];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    } @finally {
        NSLog(@"finally");
    }
     */
    
    // assert exception will occur
    XCTAssertThrows([[NSMutableString alloc] initWithString:nilObject]);
    XCTAssertThrows([[NSString alloc] initWithString:nilObject]);
}

@end
