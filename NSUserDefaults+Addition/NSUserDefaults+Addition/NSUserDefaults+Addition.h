//
//  NSUserDefaults+Addition.h
//  AppTest
//
//  Created by wesley_chen on 10/01/2018.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Addition)

// @see https://stackoverflow.com/a/33376522
- (NSSet *)setForKey:(NSString *)defaultName;
- (void)setSet:(NSSet *)set forKey:(NSString *)defaultName;

@end
