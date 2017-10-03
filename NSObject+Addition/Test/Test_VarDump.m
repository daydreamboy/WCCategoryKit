//
//  Test_VarDump.m
//  NSObject+Addition
//
//  Created by wesley chen on 16/4/17.
//
//

#import <XCTest/XCTest.h>

#import "NSObject+VarDump.h"

@interface Thing : NSObject
@end
@implementation Thing
@end

// class with description
@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@end
@implementation Person

- (instancetype)init {
    self = [super init];

    if (self) {
        _name = @"unknown";
    }

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> - name: %@", NSStringFromClass([self class]), self, self.name];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%p %@", self, self.name];
}

@end

@interface Test_VarDump : XCTestCase
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *arr;
@end

@implementation Test_VarDump

- (void)setUp {
    [super setUp];
    NSLog(@"\n");

    self.dict = @{
        @"int": @(1),
        @"float": @(3.14f),
        @"double": @(3.1425926314),
        @"bool": @(YES),
        @"dict": @{
            @"string1": @"value1",
            @"string2": @"value2",
            @"null": [NSNull null],
        },
        @"dict2": @{
            @"string1": @"value1",
            @"string2": @"value2"
        },
        @{
            @"key": @"value"
        }: @"string",
        @(YES): @(1),
        @(0): @(NO),
        [NSNull null]: @"null",
        @"empty dict": @{},
        @"中文key": @"中文value"
    };

    self.arr = @[
        @(1),
        @"string",
        @(3.14),
        @(NO),
        [NSNull null],
        @[
            @(1),
            @"string",
            @(3.14),
            @(NO),
            [NSNull null],
        ],
        self.dict,
        @""
    ];
}

- (void)tearDown {
    NSLog(@"\n");
    [super tearDown];
}

- (void)test_wc_object_dump_with_NSDictionary {
    // Case 1: NSDictionary as root node
    NSDictionary *dict1 = self.dict;

    NSLog(@"%@", wc_object_dump(dict1));
    NSLog(@"%@", dict1);

    NSLog(@"===============================================\n");

    // Case 2: empty NSDictionary
    NSDictionary *dict2 = @{};

    NSLog(@"%@", wc_object_dump(dict2));
    NSLog(@"%@", dict2);
    
    NSLog(@"===============================================\n");
    
    NSDictionary *dict3 = @{
        @"special chars": @"It's \"Tom\".\n"
    };
    
    NSLog(@"%@", [[dict3 allValues] firstObject]);
    NSLog(@"%@", wc_object_dump(dict3));
    NSLog(@"%@", dict3);
}

- (void)test_wc_object_dump_with_NSArray {
    // Case 1: NSArray as root node
    NSArray *arr1 = self.arr;

    NSLog(@"%@", wc_object_dump(arr1));
    NSLog(@"%@", arr1);

    // Case 2: empty NSArray
    NSArray *arr2 = @[];

    NSLog(@"%@", wc_object_dump(arr2));
    NSLog(@"%@", arr2);

    // Case 3: nil
    NSLog(@"%@", nil);
    NSLog(@"%@", wc_object_dump(nil));
}

- (void)test_wc_object_dump_with_subclassOfNSObject {
    // Case 1: NSString
    NSString *string1 = @"1234";

    NSLog(@"%@", wc_object_dump(string1));
    NSLog(@"%@", string1);

    // Case 2: NSNumber as integer, float, double, and bool
    NSNumber *number1 = @(1234);
    NSLog(@"%@", wc_object_dump(number1));
    NSLog(@"%@", number1);

    NSNumber *number2 = @(3.14);
    NSLog(@"%@", wc_object_dump(number2));
    NSLog(@"%@", number2);

    NSNumber *number3 = @(3.14f);
    NSLog(@"%@", wc_object_dump(number3));
    NSLog(@"%@", number3);

    NSNumber *number4 = @(YES);
    NSLog(@"%@", wc_object_dump(number4));
    NSLog(@"%@", number4);

    // Case 3: NSNull
    NSNull *null = [NSNull null];
    NSLog(@"%@", wc_object_dump(null));
    NSLog(@"%@", null);

    // Case 4: Customzied Object as root node
    Thing *thing = [[Thing alloc] init];
    NSLog(@"%@", wc_object_dump(thing));
    NSLog(@"%@", thing);

    Person *person = [[Person alloc] init];
    NSLog(@"%@", wc_object_dump(person));
    NSLog(@"%@", person);

    // Case 5: Customzied Object nested in NSDictionary
    NSDictionary *dict1 = @{
        @"thing": thing,
        @"person": person,
        @"key": @"value",
    };
    NSLog(@"%@", wc_object_dump(dict1));
    NSLog(@"%@", dict1);

    // Case 5: Customzied Object nested in NSArray
    NSArray *arr1 = @[
        thing,
        person,
        @(1234)
    ];
    NSLog(@"%@", wc_object_dump(arr1));
    NSLog(@"%@", arr1);
}

@end
