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

#pragma mark

@interface NSString (Addition)

#pragma mark - Substring

- (NSString *)substringAtLocation:(NSUInteger)location length:(NSUInteger)length;
- (NSString *)substringInCharacterSet:(NSCharacterSet *)characterSet;

- (NSString *)insertSeparator:(NSString *)separator atInterval:(NSInteger)interval;
- (NSString *)stripHTMLTags;

- (NSString *)collapsedStringWithCharacters:(NSString *)characters;

- (NSUInteger)lengthWithChineseCharacter;
- (NSUInteger)occurrenceOfSubstring:(NSString *)substring;

#pragma mark - Get multiple NSRange of all subtring

- (NSArray *)rangesOfSubstring:(NSString *)substring;

#pragma mark - Handle url string

- (NSString *)valueOfUrlForKey:(NSString *)key;
- (NSString *)valueOfUrlForKey:(NSString *)key usingConnector:(NSString *)connector usingSeparator:(NSString *)separator;
- (NSString *)urlEncodedStringWithEncoding:(NSStringEncoding)encoding;
- (NSString *)urlEncodedString;
- (NSString *)urlDecodedString;
- (NSDictionary *)urlKeyValues;

#pragma mark - Convert JSON string to NSArray/NSDictionary

- (id)jsonObject NS_AVAILABLE_IOS(5_0);
- (NSArray *)jsonArray NS_AVAILABLE_IOS(5_0);
- (NSDictionary *)jsonDict NS_AVAILABLE_IOS(5_0);

#pragma mark - Convert NSString to JSON string

- (NSString *)jsonEscapedString;

#pragma mark - Encryption/Decryption

- (NSString *)MD5;

#pragma mark - Generate special strings

+ (NSString *)randomStringWithLength:(NSUInteger)length;
+ (NSString *)randomStringWithCharacters:(NSString *)characters length:(NSUInteger)length;
- (NSString *)spacedStringWithFormat:(NSString *)formatString;

#pragma mark - Check strings

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

#pragma mark - Escape & Unescaped String

- (NSString *)unescapedString;

#pragma mark - Base64 Encode/Decode

- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;

#pragma mark - Handle Paths

- (NSString*)stringWithPathRelativeTo:(NSString*)anchorPath;

@end
