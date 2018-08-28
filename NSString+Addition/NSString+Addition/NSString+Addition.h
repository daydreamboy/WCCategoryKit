//
//  NSString+Addition.h
//  NSString+Addition
//
//  Created by wesley chen on 15/4/10.
//  Copyright (c) 2015年 wesley chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - NSString Functions

#pragma mark > String Path

FOUNDATION_EXPORT NSString* SubpathInCacheFolder(NSString *subpath);
FOUNDATION_EXPORT NSString* SubpathInDocumentFolder(NSString *subpath);
FOUNDATION_EXPORT NSString* SubpathInLibraryFolder(NSString *subpath);
FOUNDATION_EXPORT NSString* SubpathInFolder(NSString *subpath, NSSearchPathDirectory systemFolder);

#pragma mark > String Path

FOUNDATION_EXPORT NSString* BinaryStringFromInt64(int64_t intValue);
/**
 Convert int32 to binary string

 @param intValue the int value of 32 bits
 @return the NSString with binary style, e.g. @"01010"
 
 @see http://iosdevelopertips.com/objective-c/convert-integer-to-binary-nsstring.html
 */
FOUNDATION_EXPORT NSString* BinaryStringFromInt32(int32_t intValue);
FOUNDATION_EXPORT NSString* BinaryStringFromInt16(int16_t intValue);
FOUNDATION_EXPORT NSString* BinaryStringFromInt8(int8_t intValue);

#pragma mark -

@interface NSString (Addition)

#pragma mark - String Modification

- (NSString *)insertSeparator:(NSString *)separator atInterval:(NSInteger)interval;
- (NSString *)stripHTMLTags;
- (NSString *)collapsedStringWithCharacters:(NSString *)characters;

#pragma mark - String Measuration (e.g. length, number of substring, range, ...)

- (NSUInteger)lengthWithChineseCharacter;
- (NSUInteger)occurrenceOfSubstring:(NSString *)substring;
/// get substring's ranges of its all occurrence
- (NSArray *)rangesOfSubstring:(NSString *)substring;
/// Calculte text size for multiple lines
- (CGSize)textSizeForMultipleLineWithWidth:(CGFloat)width attributes:(NSDictionary *)attributes;

#pragma mark - Handle String As Specific Strings

#pragma mark > Handle String As Path

- (NSString *)stringWithPathRelativeTo:(NSString *)anchorPath;

#pragma mark - String Conversion

#pragma mark > Url Encode/Decode

/// encode with UTF8
- (NSString *)urlEncodedString;
/// decode with UTF8
- (NSString *)urlDecodedString;
- (NSString *)urlEncodedStringWithEncoding:(NSStringEncoding)encoding;

#pragma mark > Escape/Unescape String

- (NSString *)jsonEscapedString;
/**
 *  Converting escaped utf8 characters back to their original form, e.g. @"\\U5378\\U8f7d\\U5e94\\U7528" => @"卸载应用"
 *
 *  @sa http://stackoverflow.com/questions/2099349/using-objective-c-cocoa-to-unescape-unicode-characters-ie-u1234/11615076#11615076
 *
 *  @return the unescaped string
 */
- (NSString *)unescapedUnicodeString;
/**
 Companion with unescapedUnicodeString, escape raw unicode string, e.g. ESCAPE_UNICODE_CSTR("\U5e97\U94fa\U6d4b\U8bd5\U8d26\U53f7") => @"\"\\U5e97\\U94fa\\U6d4b\\U8bd5\\U8d26\\U53f7\""

 @param ... the c string
 @return the NSString
 */
#define ESCAPE_UNICODE_CSTR(...) @#__VA_ARGS__

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

//#pragma mark - String Validation
//
//- (BOOL)charactersAscendOrDescendWithLength:(NSInteger)length;
//- (BOOL)uniformedBySingleCharacter;
//- (BOOL)noneNegativeInteger;
//- (BOOL)positiveInteger;
//- (BOOL)composedOfNumbers;
//- (BOOL)composedOfLetters;
//- (BOOL)composedOfLettersLowercase;
//- (BOOL)composedOfLettersUppercase;
//- (BOOL)composedOfChineseCharacters;
//- (BOOL)alphanumeric;

@end
