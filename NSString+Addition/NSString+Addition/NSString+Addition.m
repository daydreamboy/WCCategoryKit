//
//  NSString+Addition.m
//  NSString+Addition
//
//  Created by wesley chen on 15/4/10.
//  Copyright (c) 2015年 wesley chen. All rights reserved.
//

#import "NSString+Addition.h"
#import <CommonCrypto/CommonDigest.h>

#define DEBUG_LOG 1

#ifndef NSPREDICATE
#define NSPREDICATE(expression)    ([NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression])
#endif

#pragma mark - NSString Functions

#pragma mark > String Path

NSString* SubpathInCacheFolder(NSString *subpath)
{
    return SubpathInFolder(subpath, NSCachesDirectory);
}

NSString* SubpathInDocumentFolder(NSString *subpath)
{
    return SubpathInFolder(subpath, NSDocumentDirectory);
}

NSString* SubpathInLibraryFolder(NSString *subpath)
{
    return SubpathInFolder(subpath, NSLibraryDirectory);
}

NSString* SubpathInFolder(NSString *subpath, NSSearchPathDirectory systemFolder)
{
    static NSMutableDictionary *sDict = nil;
    
    if (!sDict) {
        sDict = [NSMutableDictionary dictionary];
    }
    
    NSNumber *key = @(systemFolder);
    if (!sDict[key]) {
        NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(systemFolder, NSUserDomainMask, YES) firstObject];
        sDict[key] = directoryPath;
    }
    
    NSString *folderPath = [sDict[key] stringByAppendingPathComponent:subpath];
    
    return folderPath;
}

#pragma mark > String Path

#pragma mark Private Methods

// Note: intValue's type maximum allow int64_t
NSString* BinaryStringFromIntX(int64_t intValue, int64_t numberOfBits) {
    int64_t indexOfDigits = numberOfBits;
    
    // C array - storage plus one for null
    char digits[numberOfBits + 1];
    
    while (indexOfDigits-- > 0)
    {
        // Set digit in array based on rightmost bit
        digits[indexOfDigits] = (intValue & 1) ? '1' : '0';
        
        // Shift incoming value one to right
        intValue >>= 1;
    }
    
    // Append null
    digits[numberOfBits] = 0;
    
    // Return the binary string
    return [NSString stringWithUTF8String:digits];
}

NSString* BinaryStringFromInt64(int64_t intValue) {
    int sizeOfByte = 8,            // 8 bits per byte
    numberOfBits = (sizeof(int64_t)) * sizeOfByte; // Total bits
    
    return BinaryStringFromIntX(intValue, numberOfBits);
}

NSString* BinaryStringFromInt32(int32_t intValue) {
    int sizeOfByte = 8,            // 8 bits per byte
    numberOfBits = (sizeof(int32_t)) * sizeOfByte; // Total bits
    
    return BinaryStringFromIntX(intValue, numberOfBits);
}

NSString* BinaryStringFromInt16(int16_t intValue) {
    int sizeOfByte = 8,            // 8 bits per byte
    numberOfBits = (sizeof(int16_t)) * sizeOfByte; // Total bits
    
    return BinaryStringFromIntX(intValue, numberOfBits);
}

NSString* BinaryStringFromInt8(int8_t intValue) {
    int sizeOfByte = 8,            // 8 bits per byte
    numberOfBits = (sizeof(int8_t)) * sizeOfByte; // Total bits
    
    return BinaryStringFromIntX(intValue, numberOfBits);
}

#pragma mark -

@implementation NSString (Addition)

#pragma mark - Substring String

/*!
 *  Subtring at location with length
 *
 *  @param location Started by 0
 *  @param length   If length exceed the left length (total length - location), will substring left all characters from the location
 *
 *  @return nil, if location out of the string index [0..self.length]
 */
- (NSString *)substringAtLocation:(NSUInteger)location length:(NSUInteger)length {
    
    if (location < self.length) {
        
        if (length < self.length - location) {
            return [self substringWithRange:NSMakeRange(location, length)];
        }
        else {
            // Now substring from loc to the end of string
            return [self substringFromIndex:location];
        }
    }
    else {
        return nil;
    }
}

/*!
 *  从字符串中抽取第一个符合characterSet的子字符串
 *
 *  @param characterSet 匹配字符的集合
 *
 *  @return 匹配characterSet的第一个子字符串。如果没有匹配的子字符串，返回nil
 *  @code
 // Input
 NSString *originalString = @"*_?.幸运号This's my string：01234adbc5678";
 
 NSString *numberString = [originalString firstSubstringInCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
 NSLog(@"%@", numberString); // 01234
 */
- (NSString *)firstSubstringInCharacterSet:(NSCharacterSet *)characterSet {
    NSString *substring = nil;
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    
    // Throw away characters before matching the first character in characterSet
    [scanner scanUpToCharactersFromSet:characterSet intoString:NULL];
    
    // Start collecting characters in characterSet until not matching the first character in the characterSet
    [scanner scanCharactersFromSet:characterSet intoString:&substring];
    
    return substring;
}

#pragma mark - String Modification

/*!
 *  每隔一段距离插入一个分离字符串（separator）
 *
 *  @param separator 用于分离的字符串
 *  @param interval  separator之间的间距，必须大于1，否则返回字符串
 *
 *  @return 返回处理过的字符串，下标为0的位置的separator被去掉了
 */
- (NSString *)insertSeparator:(NSString *)separator atInterval:(NSInteger)interval {
    
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:self];
    
    if (interval <= 0) {
        return self;
    }
    
    for (NSInteger i = 0; i < [mutableString length]; i++) {
        if (i % (interval + 1) == 0) {
            [mutableString insertString:separator atIndex:i];
        }
    }
    NSString *retVal = [mutableString substringFromIndex:1];
    
    return retVal;
}

/*!
 *  去掉所有的HTML标签
 *
 *  @return 返回去掉所有的HTML标签的字符串
 */
- (NSString *)stripHTMLTags {
    
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:[self length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    scanner.charactersToBeSkipped = nil;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [strippedString appendString:tempText];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
    }
    
    return strippedString;
}

#pragma mark - String Measuration (e.g. length, number of substring, range, ...)

/*!
 *  将1个汉字算成2个字符长度
 */
- (NSUInteger)lengthWithChineseCharacter {
    NSUInteger len = self.length;
    
    // CJK Unified Ideographs, details see http://www.ssec.wisc.edu/~tomw/java/unicode.html
    NSString *pattern = @"[\u4e00-\u9fff]";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger numberOfMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    
    return len + numberOfMatch;
}

/*!
 *  Check occurrence times of substring in string
 *
 *  @param substring the subString to search.
 *         If substring is \@"", return 0
 *
 *  @warning substring can't be nil
 */
- (NSUInteger)occurrenceOfSubstring:(NSString *)substring {
    
    NSAssert(substring != nil, @"substring parameter can't be nil");
    
    NSArray *parts = [self componentsSeparatedByString:substring];
    if ([parts count] > 0) {
        return [parts count] - 1;
    }
    else {
        return 0;
    }
}

/*!
 *  Collapse continuous same characters into only one character, e.g. "AAABBCDD" -> "ABCD"
 *
 *  @param characters the characters should be collapsed
 *
 *  @return If the length of characters parameter is 0, return the original NSString
 */
- (NSString *)collapsedStringWithCharacters:(NSString *)characters {
    if (characters.length == 0) {
        return self;
    }
    
    NSMutableString *collapsedString = [NSMutableString string];
    __block NSString *testString; // used to ommit continuous same characters
    __block BOOL isFirstSubstring = YES;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (isFirstSubstring) {
            
            [collapsedString appendString:substring];
            testString = substring;
            
            isFirstSubstring = NO;
        }
        else {
            if (![characters rangeOfString:testString].length || ![testString isEqualToString:substring]) {
                
                [collapsedString appendString:substring];
                testString = substring;
            }
        }
    }];
    
    return collapsedString;
}

/*!
 *  Find ranges of all substrings
 *
 *  @param substring the substring maybe occurred many times
 *
 *  @return the array constructed by [NSValue valueWithRange:range]
 *
 *  @sa http://stackoverflow.com/questions/7033574/find-all-locations-of-substring-in-nsstring-not-just-first
 */
- (NSArray *)rangesOfSubstring:(NSString *)substring {
    NSRange searchRange = NSMakeRange(0, self.length);
    NSRange foundRange;
    
    NSMutableArray *arrM = [NSMutableArray array];

    while (searchRange.location < self.length) {
        searchRange.length = self.length - searchRange.location;
        foundRange = [self rangeOfString:substring options:kNilOptions range:searchRange];

        if (foundRange.location != NSNotFound) {
            // found an occurrence of the substring, and add its range to NSArray
            [arrM addObject:[NSValue valueWithRange:foundRange]];
            
            // move forward
            searchRange.location = foundRange.location + foundRange.length;
        }
        else {
            // no more substring to find
            break;
        }
    }
    
    return arrM;
}

/**
 Calculte text size for multiple lines
 
 @param width the fixed width which is expected > 0
 @param attributes the attributes for the string
 @return the text size
 */
- (CGSize)textSizeForMultipleLineWithWidth:(CGFloat)width attributes:(NSDictionary *)attributes {
    if (width > 0) {
        return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                               attributes:attributes
                                  context:nil].size;
    }
    else {
        return CGSizeZero;
    }
}

#pragma mark - Handle String As Specific Strings

#pragma mark > Handle String As Path

/**
 Get a relative path based on anchorPath

 @param anchorPath the anchor path which is based on
 @return the relative path, e.g. "b/c", "../b/c"
 
 @see http://stackoverflow.com/questions/6539273/objective-c-code-to-generate-a-relative-path-given-a-file-and-a-directory
 */
- (NSString *)stringWithPathRelativeTo:(NSString *)anchorPath {
    NSArray *pathComponents = [self pathComponents];
    NSArray *anchorComponents = [anchorPath pathComponents];
    
    NSInteger componentsInCommon = MIN([pathComponents count], [anchorComponents count]);
    for (NSInteger i = 0, n = componentsInCommon; i < n; i++) {
        if (![[pathComponents objectAtIndex:i] isEqualToString:[anchorComponents objectAtIndex:i]]) {
            componentsInCommon = i;
            break;
        }
    }
    
    NSUInteger numberOfParentComponents = [anchorComponents count] - componentsInCommon;
    NSUInteger numberOfPathComponents = [pathComponents count] - componentsInCommon;
    
    NSMutableArray *relativeComponents = [NSMutableArray arrayWithCapacity:numberOfParentComponents + numberOfPathComponents];
    for (NSInteger i = 0; i < numberOfParentComponents; i++) {
        [relativeComponents addObject:@".."];
    }
    [relativeComponents addObjectsFromArray:[pathComponents subarrayWithRange:NSMakeRange(componentsInCommon, numberOfPathComponents)]];
    return [NSString pathWithComponents:relativeComponents];
}

#pragma mark - String Conversion

#pragma mark > Url Encode/Decode

/**
 *  Get a url-encoding string
 *
 *  @param encoding NSUTF8StringEncoding 
 *
 *  @sa http://stackoverflow.com/questions/8088473/how-do-i-url-encode-a-string
 *  @sa AFPercentEscapedQueryStringPairMemberFromStringWithEncoding method in AFHTTPClient.m
 *  @note https://en.wikipedia.org/wiki/Percent-encoding
 *
 *  @return the url-encoding string
 */
- (NSString *)urlEncodedStringWithEncoding:(NSStringEncoding)encoding {
    static NSString *const kAFCharactersToBeEscaped = @":/?&=;+!@#$()',*";
    static NSString *const kAFCharactersToLeaveUnescaped = @"[].";

    NSString *encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, (__bridge CFStringRef)kAFCharactersToLeaveUnescaped, (__bridge CFStringRef)kAFCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));

    return encodedString;
}

/**
 *  Get a url-encoding string with UTF-8 encoding
 *
 *  @return the url-encoding string
 */
- (NSString *)urlEncodedString {
    return [self urlEncodedStringWithEncoding:NSUTF8StringEncoding];
}

/*!
 *  Get a url-decoded string with UTF-8 encoding
 *
 *  @return the url-decoding string
 *  
 *  @sa http://isobar.logdown.com/posts/211030-url-encode-decode-in-ios
 */
- (NSString *)urlDecodedString {
    NSString *decodedString;

    if ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending) {
        // iOS 9 or later
        decodedString = CFBridgingRelease(
                CFURLCreateStringByReplacingPercentEscapes(
                    kCFAllocatorDefault,
                    (__bridge CFStringRef)self,
                    CFSTR("")
                    )
                );
    }
    else {
        decodedString = CFBridgingRelease(
                CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                    kCFAllocatorDefault,
                    (__bridge CFStringRef)self,
                    CFSTR(""),
                    kCFStringEncodingUTF8
                    )
                );
    }

    return decodedString;
}

#pragma mark > Base64 Encode/Decode

/*!
 *  Encode plain string into base64 string
 *
 *  @return one-line base64 string
 */
- (NSString *)base64EncodedString {
    NSString *string;
    
    if ([self respondsToSelector:@selector(base64EncodedDataWithOptions:)]) {
        // iOS >= `7.0`
        // one line base64 string
        NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedDataWithOptions:0];
        string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        // one line base64 string
        string = [[self dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
#pragma GCC diagnostic pop
    }
    
    return string;
}

/*!
 *  Decode base64 string to plain string
 *
 *  @return one-line plain string
 */
- (NSString *)base64DecodedString {
    // iOS >= `7.0`
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

#pragma mark > JSON String to id/NSArray/NSDictionary

/*!
 *  Convert the string to NSArray or NSDictionary object using JSON format
 *
 *  @return If the string is not JSON formatted, return nil.
 */
- (id)jsonObject {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) {
        return nil;
    }
    
    @try {
        NSError *error;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (!jsonObject) {
            NSLog(@"[%@] error parsing JSON: %@", NSStringFromClass([self class]), error);
        }
        return jsonObject;
    }
    @catch (NSException *exception) {
        NSLog(@"[%@] an exception occured:\n%@", NSStringFromClass([self class]), exception);
    }
    
    return nil;
}

/*!
 *  Convert the string to NSArray object using JSON format
 *
 *  @return If the string is not JSON formatted or a JSON array object, return nil.
 */
- (NSArray *)jsonArray {
    NSArray *jsonArray = [self jsonObject];
    if ([jsonArray isKindOfClass:[NSArray class]]) {
        return jsonArray;
    }
    else {
        return nil;
    }
}

/*!
 *  Convert the string to NSDictionary object using JSON format
 *
 *  @return If the string is not JSON formatted or a JSON dictionary object, return nil.
 */
- (NSDictionary *)jsonDict {
    NSDictionary *jsonDict = [self jsonObject];
    if ([jsonDict isKindOfClass:[NSDictionary class]]) {
        return jsonDict;
    }
    else {
        return nil;
    }
}

#pragma mark > Escape/Unescape String

/*!
 *  Convert NSString to JSON string by escaping some special characters, e.g. \、"
 *
 *  @return the JSON string from NSString
 *
 *  @sa http://stackoverflow.com/questions/15843570/objective-c-how-to-convert-nsstring-to-escaped-json-string
 *  @sa http://www.codza.com/converting-nsstring-to-json-string
 */
- (NSString *)jsonEscapedString {
    NSMutableString *stringM = [NSMutableString stringWithString:self];

    [stringM replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [stringM length])];
    [stringM replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [stringM length])];
    [stringM replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [stringM length])];
    [stringM replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [stringM length])];
    [stringM replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [stringM length])];
    [stringM replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [stringM length])];
    [stringM replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [stringM length])];
    
    return [NSString stringWithString:stringM];
}

- (NSString *)unescapedUnicodeString {
    // Bug: The escaped string must use \u not \U, CFStringTransform only treats \u
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\\U" withString:@"\\u"];
    // Note: remove left or right redundant `"` if needed
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    NSMutableString *unescapedString = [string mutableCopy];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)unescapedString, NULL, transform, YES);
    
    return [unescapedString copy];
}

#pragma mark > Hash

/*!
 *  MD5 encryption
 *
 *  @header #import <CommonCrypto/CommonDigest.h>
 */
- (NSString *)MD5 {
	if (self.length) {
		const char *cStr = [self UTF8String];
		unsigned char result[16];
		CC_MD5(cStr, (unsigned int)strlen(cStr), result);
		return [NSString stringWithFormat:
		        @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
		        result[0], result[1], result[2], result[3],
		        result[4], result[5], result[6], result[7],
		        result[8], result[9], result[10], result[11],
		        result[12], result[13], result[14], result[15]
		];
	}
	else {
		return nil;
	}
}

#pragma mark - String Generation

/*!
 *  Generate a random alphanumeric string from @"a-zA-Z0-9"
 *
 *  @param len  the length of random string
 *  @sa http://stackoverflow.com/questions/2633801/generate-a-random-alphanumeric-string-in-cocoa
 */
+ (NSString *)randomStringWithLength:(NSUInteger)length {
    NSString *characters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

	return [self randomStringWithCharacters:characters length:length];
}

/*!
 *  Generate a random alphanumeric string from characters parameter
 *
 *  @param characters   the character set
 *  @param len          the length of random string
 *
 *  @return nil if len = 0 or characters is empty
 */
+ (NSString *)randomStringWithCharacters:(NSString *)characters length:(NSUInteger)length {
    if (!characters.length || length == 0) {
        return nil;
    }
    else {
        NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
        for (int i = 0; i < length; i++) {
            [randomString appendFormat:@"%C", [characters characterAtIndex:arc4random_uniform((u_int32_t)characters.length)]];
        }
        
        return randomString;
    }
}

/*!
 *  Convert non-spaced string into spaced string with the specified format, e.g. @"12312341234" to @"123 1234 1234" with format @"XXX XXXX XXXX"
 *
 *  @param formatString the format string contains spaces and non-space characters
 *
 *  @return the spaced string
 *
 *  @warning 1. The trailing space in formatString will be ignored, e.g. @"abc" to @" a b c" with format @" X X X "
 *     <br/> 2. If the string contains space, the space will be trimmed
 */
- (NSString *)spacedStringWithFormat:(NSString *)formatString {
    NSAssert(!formatString || [formatString isKindOfClass:[NSString class]], @"%@ is not a NSString", formatString);
    
    NSString *trimmedString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSMutableString *stringM = [NSMutableString string];
    NSUInteger i = 0;
    NSUInteger j = 0;
    for (i = 0; i < formatString.length && j < trimmedString.length; i++) {
        
        unichar char1 = [formatString characterAtIndex:i];
        unichar char2 = [trimmedString characterAtIndex:j];
        
        if (char1 == ' ') {
            [stringM appendString:@" "];
        }
        else {
            [stringM appendFormat:@"%C", char2];
            j++;
        }
    }
    
    for (; j < trimmedString.length; j++) {
        [stringM appendFormat:@"%C", [trimmedString characterAtIndex:j]];
    }
    
    return [stringM copy];
}

/// @see https://stackoverflow.com/questions/1058736/how-to-create-a-nsstring-from-a-format-string-like-xxx-yyy-and-a-nsarr
+ (NSString *)stringWithFormat:(NSString *)format array:(NSArray *)arguments {
    if (arguments.count > 10) {
        @throw [NSException exceptionWithName:NSRangeException reason:@"Maximum of 10 arguments allowed" userInfo:@{@"collection": arguments}];
    }
    NSArray *args = [arguments arrayByAddingObjectsFromArray:@[@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X",@"X"]];
    return [NSString stringWithFormat:format, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]];
}

#pragma mark - String Validation

/*!
 *  Check string's characters is ascend or descend with a minimum length
 *
 *  @param length the ascend or descend length
 *
 *  @return If ascend or descend substring's length exceed the parameter length, return YES
 */
- (BOOL)charactersAscendOrDescendWithLength:(NSInteger)length {
    if (length < 2 && self.length < 2) {
        return NO;
    }
    
    NSInteger ascendCount = 1;
    NSInteger descendCount = 1;
    for (NSInteger i = 1; i < self.length; i++) {
        unichar previousChar = [self characterAtIndex:i - 1];
        unichar currentChar = [self characterAtIndex:i];
        
        ascendCount = (currentChar - previousChar == 1 ? ++ascendCount : 1);
        descendCount = (currentChar - previousChar == -1 ? ++descendCount : 1);
        
        if (ascendCount >= length || descendCount >= length) {
            return YES;
        }
    }
    
    return NO;
}

/*!
 *  Check string if composed by only one character
 *
 *  @return If string is nil, return NO
 */
- (BOOL)uniformedBySingleCharacter {
    NSRange range = NSMakeRange(0, self.length);
    
    __block BOOL uniformed = YES;
    __block NSString *previousString = nil;
    
    [self enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (!previousString) {
            previousString = substring;
        }
        else {
            if (![previousString isEqualToString:substring]) {
                uniformed = NO;
                *stop = YES;
            }
        }
    }];
    
    return uniformed;
}

/*!
 *  Check string if non-negative integer value, e.g. @"0", @"1", @"10"
 *
 *  @return If YES, the string is integer value and NUMBER(string) >= 0.
 *  @warning <br/> 1. positive sign (+) is NOT allowed <br/> 2. leading zeros are NOT allowed, e.g. @"00", @"010"
 */
- (BOOL)noneNegativeInteger {
    return [self naturalInteger];
}

/*!
 *  Check string if positive integer value, e.g. @"1", @"2"
 *
 *  @return If YES, the string is integer value and NUMBER(string) > 0.
 */
- (BOOL)positiveInteger {
    return [NSPREDICATE(@"^[1-9]+[0-9]*$") evaluateWithObject:self];;
}

/*!
 *  Check string if numeric, e.g. @"000", @"010", @"1"
 *
 *  @return NO, if empty string @"" or nil, or not a numeric string
 */
- (BOOL)composedOfNumbers {
    return [NSPREDICATE(@"^[0-9]+[0-9]*$") evaluateWithObject:self];
}

/*!
 *  Check string only if contains a-z and A-Z, e.g. @"aaa", @"ABC", @"abcABC"
 *
 *  @return NO, if empty string @"" or nil, or contains non-letter characters
 */
- (BOOL)composedOfLetters {
    return [NSPREDICATE(@"^[a-zA-Z]+[a-zA-Z]*$") evaluateWithObject:self];
}

- (BOOL)composedOfLettersLowercase {
    return [NSPREDICATE(@"^[a-z]+[a-z]*$") evaluateWithObject:self];
}

- (BOOL)composedOfLettersUppercase {
    return [NSPREDICATE(@"^[A-Z]+[A-Z]*$") evaluateWithObject:self];
}

/*!
 *  Check string if chinese characters, e.g. @"中文", @"中国"
 *
 *  @sa http://www.ssec.wisc.edu/~tomw/java/unicode.html#x4E00 (CJK Unified Ideographs)
 *  @return NO, if empty string @"" or nil, or contains non-chinese characters
 */
- (BOOL)composedOfChineseCharacters {
    return [NSPREDICATE(@"^[\u4e00-\u9fa5]+[\u4e00-\u9fa5]*$") evaluateWithObject:self];
}

/*!
 *  Check string if alphabetical and numerical
 *
 *  @return YES if string contains only letters (uppercase or lowercase) and numbers
 *
 *  @sa http://stackoverflow.com/questions/7546235/check-if-nsstring-contains-alphanumeric-underscore-characters-only
 */
- (BOOL)alphanumeric {
    
    if (self.length) {
        static NSCharacterSet *characterSet;
        if (!characterSet) {
            characterSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
        }
        
        return ([self rangeOfCharacterFromSet:[characterSet invertedSet]].location == NSNotFound);
    }
    else {
        // empty string is not alphanumeric
        return NO;
    }
}

#pragma mark - String Validation (Private)

/*!
 *  Check string if non-negative integer value
 *
 *  @return YES, if the string is integer value and NUMBER(string) >= 0.
 *  @warning <br/> 1. positive sign (+) is NOT allowed <br/> 2. leading zeros are NOT allowed, e.g. @"00", @"010"
 *  @sa http://stackoverflow.com/questions/6644004/how-to-check-if-nsstring-is-contains-a-numeric-value
 */
- (BOOL)naturalInteger {
    
    if (self.length) {
        
        if ([self hasPrefix:@"0"] && self.length != 1) {
            return NO;
        }
        else {
            NSCharacterSet *noneNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            NSRange range = [self rangeOfCharacterFromSet:noneNumberSet];
            
            return range.location == NSNotFound;
        }
    }
    else {
        return NO;
    }
}

@end

