//
//  Test.m
//  Test
//
//  Created by wesley chen on 16/4/15.
//
//

#import <XCTest/XCTest.h>

@interface Test : XCTestCase

@end

@implementation Test

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_NSNumber {
    // @sa http://nshipster.com/bool/
    __unused NSNumber *n1 = @(YES);
    __unused NSNumber *n2 = @(true);
    __unused NSNumber *n3 = @(1);
    __unused NSNumber *n4 = @(TRUE);
    __unused NSNumber *n5 = (__bridge NSNumber *)kCFBooleanTrue;
    __unused NSNumber *n6 = [@(1)copy];

    NSLog(@"\n");

//    NSNumber *n = [NSNumber numberWithBool:YES];
//    const char *type = [n objCType];
//
//    n = @(1);
//    const char *type2 = [n objCType];
//
//    fprintf(stderr, "%s", type);
//    printf("%s", type);
//
//    if (strcmp([n objCType], @encode(BOOL)) == 0) {
//        NSLog(@"this is a bool");
//    }
//    else if (strcmp([n objCType], @encode(int)) == 0) {
//        NSLog(@"this is an int");
//    }
//    else {
//        NSLog(@"Other");
//    }
//
//    NSNumber *n2 = @(false);
//    const char *type3 = [n2 objCType];
//
//    const char *s1 = @encode(bool);
//    const char *s2 = @encode(BOOL);
}

@end
