//
//  NSUserDefaults+Addition.m
//  AppTest
//
//  Created by wesley_chen on 10/01/2018.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import "NSUserDefaults+Addition.h"

@implementation NSUserDefaults (Addition)

- (NSSet *)setForKey:(NSString *)defaultName {
    NSArray *array = [self arrayForKey:defaultName];
    if (array) {
        return [NSSet setWithArray:array];
    }
    else {
        return nil;
    }
}

- (void)setSet:(NSSet *)set forKey:(NSString *)defaultName {
    if (set) {
        [self setObject:[set allObjects] forKey:defaultName];
    }
    else {
        [self setObject:nil forKey:defaultName];
    }
}

@end
