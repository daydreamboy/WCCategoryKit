//
//  Test.m
//  Test
//
//  Created by wesley chen on 15/4/11.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSArray+Addition.h"

@interface Job : NSObject
@property (nonatomic, strong) NSString *name;
- (instancetype)initWithName:(NSString *)name;
@end

@implementation Job

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    
    return self;
}

@end

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) Job *job;

- (instancetype)initWithName:(NSString *)name age:(NSNumber *)age;

@end

@implementation Person

- (instancetype)initWithName:(NSString *)name age:(NSNumber *)age {
    if (self = [super init]) {
        _name = name;
        _age = age;
    }
    
    return self;
}

@end

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

- (void)testSort {
    
    Person *p1 = [[Person alloc] initWithName:@"Alice" age:@(21)];
    Person *p2 = [[Person alloc] initWithName:@"Bob" age:@(25)];
    Person *p3 = [[Person alloc] initWithName:@"Carl" age:@(24)];
    
    NSArray *arr = @[p1, p2, p3];
    NSArray *sortedArray1 = [arr sortedArrayUsingComparator:^NSComparisonResult(Person *obj1, Person *obj2) {
        // Ascend
        return [obj1.age compare:obj2.age];
    }];
    NSLog(@"%@", sortedArray1);
    
    NSArray *sortedArray2 = [arr sortedArrayUsingComparator:^NSComparisonResult(Person *obj1, Person *obj2) {
        // Descend
        return [obj2.age compare:obj1.age];
    }];
    NSLog(@"%@", sortedArray2);
}

#pragma mark - 

- (void)testCollapsedArrayWithKeyPaths_nil {
    
    // Preparation
    id item1;
    id item2;
    id item3;
    id item4;
    id item5;
    NSArray *uniqueArray;
    NSMutableArray *redundantArray;
    
    // Case 1:
    redundantArray = [NSMutableArray array];
    
    item1 = @"item1";
    [redundantArray addObject:item1];
    
    item2 = @"item1";
    [redundantArray addObject:item2];
    
    item3 = [item1 mutableCopy];
    [redundantArray addObject:item3];
    
    uniqueArray = [redundantArray collapsedArrayWithKeyPaths:nil];
    XCTAssertTrue(uniqueArray.count == 1);
    
    // Case 2:
    redundantArray = [NSMutableArray array];
    
    item1 = [NSString stringWithFormat:@"%@", @"item1"];
    [redundantArray addObject:item1];
    
    item2 = [NSString stringWithFormat:@"%@", @"item1"];
    [redundantArray addObject:item2];
    
    item3 = item1;
    [redundantArray addObject:item3];
    
    uniqueArray = [redundantArray collapsedArrayWithKeyPaths:nil];
    XCTAssertTrue(uniqueArray.count == 1);
    
    // Case 3:
    redundantArray = [NSMutableArray array];
    
    item1 = [NSString stringWithFormat:@"%@", @"item1"];
    [redundantArray addObject:item1];
    
    item2 = [NSString stringWithFormat:@"%@", @"item2"];
    [redundantArray addObject:item2];
    
    item3 = item1;
    [redundantArray addObject:item3];
    
    uniqueArray = [redundantArray collapsedArrayWithKeyPaths:nil];
    XCTAssertTrue(uniqueArray.count == 2);

    // Case 4:
    redundantArray = [NSMutableArray array];
    
    [redundantArray addObject:@"item1"];
    [redundantArray addObject:@"item2"];
    [redundantArray addObject:[@"item1" copy]];
    
    uniqueArray = [redundantArray collapsedArrayWithKeyPaths:nil];
    XCTAssertTrue(uniqueArray.count == 2);
}

#pragma mark - Utility

- (void)testArrayWithLetters {
    
    // Case 1: uppercase letters
    NSArray *uppercaseLetters = [NSArray arrayWithLetters:YES];
    
    NSUInteger i = 0;
    for (char ch = 'A'; ch <= 'Z'; ch++) {
        NSString *letter = [NSString stringWithFormat:@"%c", ch];
        XCTAssertEqualObjects(uppercaseLetters[i], letter);
        i++;
    }
    
    // Case 2: lowercase letters
    NSArray *lowercaseLetters = [NSArray arrayWithLetters:NO];
    
    NSUInteger j = 0;
    for (char ch = 'a'; ch <= 'z'; ch++) {
        NSString *letter = [NSString stringWithFormat:@"%c", ch];
        XCTAssertEqualObjects(lowercaseLetters[j], letter);
        j++;
    }
}

@end
