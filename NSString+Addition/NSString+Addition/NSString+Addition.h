//
//  NSString+Addition.h
//  NSString+Addition
//
//  Created by wesley chen on 15/4/10.
//  Copyright (c) 2015年 wesley chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSString Functions

FOUNDATION_EXPORT NSString* SubpathInCacheFolder(NSString *subpath);
FOUNDATION_EXPORT NSString* SubpathInDocumentFolder(NSString *subpath);
FOUNDATION_EXPORT NSString* SubpathInLibraryFolder(NSString *subpath);
FOUNDATION_EXPORT NSString* SubpathInFolder(NSString *subpath, NSSearchPathDirectory systemFolder);

#pragma mark -

@interface NSString (Addition)

#pragma mark - Substring String

- (NSString *)substringAtLocation:(NSUInteger)location length:(NSUInteger)length;
- (NSString *)firstSubstringInCharacterSet:(NSCharacterSet *)characterSet;

#pragma mark - String Modification

- (NSString *)insertSeparator:(NSString *)separator atInterval:(NSInteger)interval;
- (NSString *)stripHTMLTags;
- (NSString *)collapsedStringWithCharacters:(NSString *)characters;

#pragma mark - String Measuration (e.g. length, number of substring, range, ...)

- (NSUInteger)lengthWithChineseCharacter;
- (NSUInteger)occurrenceOfSubstring:(NSString *)substring;
/// get substring's ranges of its all occurrence
- (NSArray *)rangesOfSubstring:(NSString *)substring;

#pragma mark - Handle String As Specific Strings

#pragma mark > Handle String As Url

/// get value for key like `key1=value1&key2=value2`
- (NSString *)valueOfUrlForKey:(NSString *)key;
- (NSString *)valueOfUrlForKey:(NSString *)key usingConnector:(NSString *)connector usingSeparator:(NSString *)separator;
/// get key/value like `key1=value1&key2=value2`
- (NSDictionary *)urlKeyValues;

#pragma mark > Handle String As Path

- (NSString *)stringWithPathRelativeTo:(NSString *)anchorPath;

#pragma mark - String Conversion

#pragma mark > Url Encode/Decode

/// encode with UTF8
- (NSString *)urlEncodedString;
/// decode with UTF8
- (NSString *)urlDecodedString;
- (NSString *)urlEncodedStringWithEncoding:(NSStringEncoding)encoding;

#pragma mark > JSON String to id/NSArray/NSDictionary

- (id)jsonObject NS_AVAILABLE_IOS(5_0);
- (NSArray *)jsonArray NS_AVAILABLE_IOS(5_0);
- (NSDictionary *)jsonDict NS_AVAILABLE_IOS(5_0);

#pragma mark > Escape/Unescape String

- (NSString *)jsonEscapedString;
/// unescape unicode string like @"\\U5378\\U8f7d\\U5e94\\U7528" => @"卸载应用"
- (NSString *)unescapedString;

#pragma mark > Base64 Encode/Decode

- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;

#pragma mark > Hash

- (NSString *)MD5;

#pragma mark - String Generation

+ (NSString *)randomStringWithLength:(NSUInteger)length;
+ (NSString *)randomStringWithCharacters:(NSString *)characters length:(NSUInteger)length;
- (NSString *)spacedStringWithFormat:(NSString *)formatString;
+ (NSString *)stringWithFormat:(NSString *)format array:(NSArray *)arguments;

#pragma mark - String Validation

- (BOOL)charactersAscendOrDescendWithLength:(NSInteger)length;
- (BOOL)uniformedBySingleCharacter;
- (BOOL)noneNegativeInteger;
- (BOOL)positiveInteger;
- (BOOL)composedOfNumbers;
- (BOOL)composedOfLetters;
- (BOOL)composedOfLettersLowercase;
- (BOOL)composedOfLettersUppercase;
- (BOOL)composedOfChineseCharacters;
- (BOOL)alphanumeric;

@end
