//
//  NSDictionary+Addition.h
//  NSDictionary+Addition
//
//  Created by wesley chen on 15/4/11.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addition)

#pragma mark - Safe Value for Key/KeyPath

- (NSArray *)arrayForKey:(NSString *)key;
- (NSDictionary *)dictForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;

#pragma mark - Safe Wrapping

+ (NSDictionary *)dictionaryWithKeyAndValues:(id)firstKey, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark - Override Methods

- (NSString *)debugDescription;

@end
