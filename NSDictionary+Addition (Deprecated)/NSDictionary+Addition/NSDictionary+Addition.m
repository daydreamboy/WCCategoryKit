//
//  NSDictionary+Addition.m
//  NSDictionary+Addition
//
//  Created by wesley chen on 15/4/11.
//
//

#import "NSDictionary+Addition.h"

#define DEBUG_LOG 0

@implementation NSDictionary (Addition)

/*!
 *  Get a NSArray object in the dictionary for given key
 *
 *  @param key a key or a keypath using '.'
 *
 *  @return If not found the NSArray object for the key, or the object is not NSArray, just return nil
 */
- (NSArray *)arrayForKey:(NSString *)key {
    NSAssert([key isKindOfClass:[NSString class]], @"%@ is not a NSString", key);

    NSArray *arr;

    if ([key rangeOfString:@"."].location == NSNotFound) {
        arr = self[key];
    }
    else {
        arr = [self valueForKeyPath:key];
    }

    return [arr isKindOfClass:[NSArray class]] ? arr : nil;
}

/*!
 *  Get a NSDictionary object in the dictionary for given key
 *
 *  @param key a key or a keypath using '.'
 *
 *  @return If not found the NSDictionary object for the key, or the object is not NSDictionary, just return nil
 */
- (NSDictionary *)dictForKey:(NSString *)key {
    NSAssert([key isKindOfClass:[NSString class]], @"%@ is not a NSString", key);

    NSDictionary *dict;

    if ([key rangeOfString:@"."].location == NSNotFound) {
        dict = self[key];
    }
    else {
        dict = [self valueForKeyPath:key];
    }

    return [dict isKindOfClass:[NSDictionary class]] ? dict : nil;
}

/*!
 *  Get a NSString object in the dictionary for given key
 *
 *  @param key a key or a keypath using '.'
 *
 *  @return If not found the NSString object for the key, or the object is not NSString, just return nil
 */
- (NSString *)stringForKey:(NSString *)key {
    NSAssert([key isKindOfClass:[NSString class]], @"%@ is not a NSString", key);

    NSString *string;

    if ([key rangeOfString:@"."].location == NSNotFound) {
        string = self[key];
    }
    else {
        string = [self valueForKeyPath:key];
    }

    return [string isKindOfClass:[NSString class]] ? string : nil;
}

#pragma mark - Safe Wrapping

#define DISABLE_THROW_EXCEPTION 1

/**
 *  <#Description#>
 *
 *  @param firstKey <#firstKey description#>
 *
 *  @see https://developer.apple.com/library/mac/qa/qa1405/_index.html
 *
 *  @return
 */
+ (NSDictionary *)dictionaryWithKeyAndValues:(id)firstKey, ... {
    
#ifndef __FILE_NAME__
#define __FILE_NAME__ ((strrchr(__FILE__, '/') ?: __FILE__ - 1) + 1)
#endif
    
    NSDictionary *dict;
    id eachKey;
    id eachValue;
    va_list argumentList;

    if (firstKey) { // The first argument isn't part of the varargs list,
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];

        va_start(argumentList, firstKey); // Start scanning for arguments after firstObject.
        @try {
            eachKey = firstKey;
            while (eachKey && (eachValue = va_arg(argumentList, id))) { // As many times as we can get an argument of type "id"
                [dictM setValue:eachValue forKey:eachKey];
                eachKey = va_arg(argumentList, id);
            }
        }
        @catch (NSException *exception) {
#if DISABLE_THROW_EXCEPTION
            NSLog(@"[Error][%s, line: %d] %@", __FILE_NAME__, __LINE__, exception);
#else
            [exception raise];
#endif
        }

        va_end(argumentList);

        if (eachKey && !eachValue) {
            NSString *reason = [NSString stringWithFormat:@"key & value is not paired, value for key `%@` should not be nil", eachKey];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            
#if DISABLE_THROW_EXCEPTION
            NSLog(@"[Error][%s, line: %d] %@", __FILE_NAME__, __LINE__, exception);
#else
            [exception raise];
#endif
        }

        if (dictM.count) {
            dict = [dictM copy];
        }
    }

    return dict;
}

#pragma mark - Override Methods

- (NSString *)debugDescription {
    NSMutableString *stringM = [NSMutableString stringWithString:@"{\n"];
    
    for (id key in [self allKeys]) {
        id value = [self objectForKey:key];
        [stringM appendFormat:@"\t%@ : %@\n", key, value];
    }
    [stringM appendString:@"}\n"];
    
    return stringM;
}

@end

