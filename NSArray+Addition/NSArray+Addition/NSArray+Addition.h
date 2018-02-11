//
//  NSArray+Addition.h
//  NSArray+Addition
//
//  Created by wesley chen on 15/4/11.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (Addition)

#pragma mark - Sort

//- (NSArray *)sortedArrayUsingComparator:(NSComparator)cmptr ascend:(BOOL)ascend;

#pragma mark - Remove Objects By Key Path

- (NSArray *)collapsedArrayWithKeyPaths:(NSArray *)keyPaths;

#pragma mark - Utility

+ (NSArray *)arrayWithLetters:(BOOL)isUppercase;

@end
