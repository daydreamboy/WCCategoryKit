//
//  Test.m
//  Test
//
//  Created by wesley chen on 15/4/11.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDictionary+Addition.h"

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

#pragma mark -

- (void)test_ArrayForKey {
	NSDictionary *dict = @{
		@"array": @[@"1", @"2", @"3"],
		@"dict": @{
			@"k1": @"v1",
			@"k2": @"v2",
			@"k3": @{ @"k3-k1": @"v3" },
		},
        @"string": @"a string",
	};
    
    NSArray *arr1 = [dict arrayForKey:@"array"];
    XCTAssert([arr1 isKindOfClass:[NSArray class]], @"%@ is not a NSArray", arr1);
    
    NSArray *arr2 = [dict arrayForKey:@"dict"];
    XCTAssertNil(arr2, @"%@ should be nil", arr2);
    
//    NSString *fakeDict = @"This is a fake dictionary";
//    NSArray *arr3 = [((NSDictionary *)fakeDict) arrayForKey:@"array"];
//    NSLog(@"%@", arr3);
}

- (void)test_DictForKey {
	NSDictionary *dict = @{
		@"array": @[@"1", @"2", @"3"],
		@"dict": @{
			@"k1": @"v1",
			@"k2": @"v2",
			@"k3": @{ @"k3-k1": @"v3" },
		},
        @"string": @"a string",
	};
    
    NSDictionary *dict1 = [dict dictForKey:@"dict"];
	XCTAssert([dict1 isKindOfClass:[NSDictionary class]], @"%@ is not a NSDictionary", dict1);

    NSDictionary *dict2 = [dict dictForKey:@"array"];
	XCTAssertNil(dict2, @"%@ should be nil", dict2);
}

- (void)test_StringForKey {
	NSDictionary *dict = @{
		@"array": @[@"1", @"2", @"3"],
		@"dict": @{
			@"k1": @"v1",
			@"k2": @"v2",
			@"k3": @{ @"k3-k1": @"v3" },
		},
        @"string": @"a string",
	};

	NSString *string1 = [dict stringForKey:@"dict"];
    XCTAssertNil(string1, @"%@ should be nil", string1);
    
    NSString *string2 = [dict stringForKey:@"string"];
	XCTAssert([string2 isKindOfClass:[NSString class]], @"%@ is not a NSString", string2);
    NSLog(@"string = %@", string2);
    
    NSString *string3 = [dict stringForKey:@"dict.k3.k3-k1"];
    XCTAssert([string3 isKindOfClass:[NSString class]], @"%@ is not a NSString", string3);
    NSLog(@"dict.k3.k3-k1 = %@", string3);
}

- (void)test_nil_value {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    dictM[@"key1"] = nil;
    dictM[@"key2"] = @"value";
    dictM[@"key2"] = nil;
    
    for (NSString *key in dictM.allKeys) {
        NSLog(@"%@ - %@", key, dictM[key]);
    }
    
//    NSString *value;
//    NSDictionary *dict = @{ @"key": value };
//    NSLog(@"%@", dict);
}

- (void)test_dictionaryWithKeyAndValues {
    
    id nilObject;
    
    NSDictionary *dict1 = [NSDictionary dictionaryWithKeyAndValues:nil];
    XCTAssertNil(dict1);
    
    NSDictionary *dict2 = [NSDictionary dictionaryWithKeyAndValues:nil, nil];
    XCTAssertNil(dict2);
    
    NSDictionary *dict3 = [NSDictionary dictionaryWithKeyAndValues:nilObject, nilObject, nilObject, nil];
    XCTAssertNil(dict3);
    
    NSDictionary *dict4 = [NSDictionary dictionaryWithKeyAndValues:nilObject, nilObject, nilObject, nil];
    XCTAssertNil(dict4);
    
    NSDictionary *dict5 = [NSDictionary dictionaryWithKeyAndValues:@"name", nilObject, nilObject, nil];
    XCTAssertNil(dict5);
    
    NSDictionary *dict6 = [NSDictionary dictionaryWithKeyAndValues:@"John", @"21", @"Alice", nil];
    XCTAssertEqualObjects(dict6[@"John"], @"21");
    XCTAssertNil(dict6[@"Alice"]);
    
    NSDictionary *dict7 = [NSDictionary dictionaryWithKeyAndValues:@"John", @"21", @"Alice", @"20", nil];
    XCTAssertEqualObjects(dict7[@"John"], @"21");
    XCTAssertEqualObjects(dict7[@"Alice"], @"20");
    
//    NSDictionary *dict = [NSDictionary dictionaryWithKeyAndValues:@"k", @"v"];
}

- (void)test_ternary {
    
    char *string = "/abc.m";
    char *str = (( strrchr(string, '/') ?: (string - 1)) + 1);
    NSLog(@"%s", str);
    
    char *str2 = ((( strrchr(string, '/') ?: string) - 1) + 1);
    NSLog(@"%s", str2);
}

#pragma mark - Override Methods

- (void)test_debugDescription {
    NSDictionary *dict = @{
        @"string": @"value",
        @"中文": @"值",
        @"number": @(2),
        @"dict": @{
            @"k1-level2": @"string",
        },
        @"array": @[@(1), @(2)],
    };
    
    NSLog(@"%@", dict);
    NSLog(@"--------------------");
    NSLog(@"%@", [dict debugDescription]);
}


@end
