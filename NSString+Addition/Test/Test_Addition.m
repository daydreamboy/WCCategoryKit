//
//  Test.m
//  Test
//
//  Created by wesley chen on 15/4/10.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+Addition.h"

@interface Test_Addition : XCTestCase

@end

@implementation Test_Addition

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"\n");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    NSLog(@"\n");
}

- (void)test_insertSeparator_atInterval {
    XCTAssert(YES, @"Pass");
    
    // Case 1：每隔1个字符插入一个"."
    NSString *str1 = @"您的操作过于频繁，验证码可能有延迟请收到后再输入";
    NSString *str2 = [str1 insertSeparator:@"." atInterval:1];
    NSLog(@"%@", str2);
    
    // Case 2：每隔10个字符插入一个"\n"
    NSString *str3 = @"您的操作过于频繁，验证码可能有延迟请收到后再输入";
    NSString *str4 = [str3 insertSeparator:@"\n" atInterval:10];
    NSLog(@"%@", str4);
}

#pragma mark - Subtring

- (void)test_substringAtLocation_length {
    
    NSString *str1 = @"2014-11-07 18:36:04";
    XCTAssertEqualObjects(@"11-07", [str1 substringAtLocation:5 length:5]);
    XCTAssertEqualObjects(@"18:36:04", [str1 substringAtLocation:11 length:NSUIntegerMax]);
    XCTAssertEqualObjects(@"4", [str1 substringAtLocation:str1.length - 1 length:1]);
    XCTAssertEqualObjects(@"4", [str1 substringAtLocation:str1.length - 1 length:4]);
    XCTAssertEqualObjects(@"", [@"abc" substringAtLocation:0 length:0]);
    XCTAssertEqualObjects(@"a", [@"abc" substringAtLocation:0 length:1]);
    
    XCTAssertNil([str1 substringAtLocation:str1.length length:1]);
    XCTAssertNil([@"" substringAtLocation:0 length:1]);
    XCTAssertNil([@"" substringAtLocation:0 length:0]);
    NSString *nilString = nil;
    XCTAssertNil([nilString substringAtLocation:0 length:1]);
}

- (void)test_substringInCharacter {
    // Input
    NSString *originalString = @"*_?.幸运号This's my string：01234adbc5678";
    
    NSString *substring1 = [originalString substringInCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSLog(@"%@", substring1);
    
    // Input
    NSString *originalString2 = @"*_?.This's my string.";
    
    NSString *substring2 = [originalString2 substringInCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]];
    NSLog(@"%@", substring2);
}

- (void)test_stripHTMLTags {
    NSString *htmlString = @"<html>This is a html <font style=\"blah\">string</font>.</html>";
    NSLog(@"%@", [htmlString stripHTMLTags]);
}

- (void)test_lengthWithChineseCharacter {
    NSString *str = @"Hi，中国";
    NSLog(@"len1: %lu", (unsigned long)[str length]);
    NSLog(@"len2: %lu", (unsigned long)[str lengthWithChineseCharacter]);
}

- (void)test_occurrenceOfSubstring {
    NSString *formatString = @"%@:%@";
    NSLog(@"occurence of %%@ is %ld", [formatString occurrenceOfSubstring:@"%@"]);
}

#pragma mark - multiple NSRange of all subtring

- (void)test_rangesOfSubstring {
    NSString *string =
        @"• 此操作仅限更换手机号，不影响当前账号内容\n"
        @"• 您将使用新的手机号登录当前账号\n"
        @"• 司机联系您时，将拨打您的新手机号\n"
        @"• 司机联系您时，将拨打您的新手机号\n"
        @"• 一个月只允许更换一次手机号";

    NSArray *ranges = [string rangesOfSubstring:@"•"];
    
    XCTAssertTrue(ranges.count == 5);
    for (NSUInteger i = 0; i < ranges.count; i++) {
        NSValue *value = (NSValue *)ranges[i];
        NSRange range = [value rangeValue];
        
        NSLog(@"%@", NSStringFromRange(range));
    }
    
    XCTAssertTrue([string rangesOfSubstring:@"\n"].count == 4);
    XCTAssertTrue([string rangesOfSubstring:@"司机"].count == 2);
    XCTAssertTrue([string rangesOfSubstring:@"null"].count == 0);
}

#pragma mark - Handle url string

- (void)test_valueOfUrlForKey {
    NSString *url = @"http://m.cp.360.cn/news/mobile/150410515.html?act=1&reffer=ios&titleRight=share&empty=";
    NSLog(@"titleRight=%@", [url valueOfUrlForKey:@"titleRight"]);
    NSLog(@"act=%@", [url valueOfUrlForKey:@"act"]);
    NSLog(@"reffer=%@", [url valueOfUrlForKey:@"reffer"]);
    NSLog(@"empty=%@", [url valueOfUrlForKey:@"empty"]);
}

- (void)test_valueOfUrlForKey_usingConnector_usingSeparator {
    NSString *str = @"Mon:Monday#Tue:Tuesday#Wed:Wednesday#Thurs:Thursday#Fri:Friday#Sat:Saturday#Sun:Sunday";
    NSLog(@"Mon=%@", [str valueOfUrlForKey:@"Mon" usingConnector:@":" usingSeparator:@"#"]);
    NSLog(@"today=%@", [str valueOfUrlForKey:@"today" usingConnector:@":" usingSeparator:@"#"]);
        
    NSString *cookie = @"Q=u%3D360H1491330706%26n%3D%26le%3DoT10MKA0ZvH0ZUSkYzAioD%3D%3D%26m%3D%26qid%3D1491330706%26im%3D1_t00df551a583a87f4e9%26src%3Dmpc_caipiao_os_100000%26t%3D1; T=s%3D70657b22272b33d114f2b6a6d8efcf5c%26t%3D1433590027%26lm%3D%26lf%3D1%26sk%3Db5dcb4c7fa89fe4215b2fea0d7d98d31%26mt%3D1433590027%26rc%3D%26v%3D2.0%26a%3D1";
    NSLog(@"Q=%@", [cookie valueOfUrlForKey:@"Q" usingConnector:@"=" usingSeparator:@";"]);
    NSLog(@"T=%@", [cookie valueOfUrlForKey:@"T" usingConnector:@"=" usingSeparator:@";"]);
}

- (void)test_urlEncodedStringWithEncoding {
    // TODO: test here
}

/**
 *  @sa https://en.wikipedia.org/wiki/Percent-encoding
 *  @sa online tool: http://meyerweb.com/eric/tools/dencoder/
 */
- (void)test_urlEncodedString {
    // Test unescape characters [].
    XCTAssertEqualObjects([@"[" urlEncodedString], @"[");
    XCTAssertEqualObjects([@"]" urlEncodedString], @"]");
    XCTAssertEqualObjects([@"." urlEncodedString], @".");
    
    // Test escape characters :/?&=;+!@#$()',*
    XCTAssertEqualObjects([@":" urlEncodedString], @"%3A");
    XCTAssertEqualObjects([@"/" urlEncodedString], @"%2F");
    XCTAssertEqualObjects([@"?" urlEncodedString], @"%3F");
    XCTAssertEqualObjects([@"&" urlEncodedString], @"%26");
    XCTAssertEqualObjects([@"=" urlEncodedString], @"%3D");
    XCTAssertEqualObjects([@";" urlEncodedString], @"%3B");
    XCTAssertEqualObjects([@"+" urlEncodedString], @"%2B");
    XCTAssertEqualObjects([@"!" urlEncodedString], @"%21");
    XCTAssertEqualObjects([@"@" urlEncodedString], @"%40");
    XCTAssertEqualObjects([@"#" urlEncodedString], @"%23");
    XCTAssertEqualObjects([@"$" urlEncodedString], @"%24");
    XCTAssertEqualObjects([@"(" urlEncodedString], @"%28");
    XCTAssertEqualObjects([@")" urlEncodedString], @"%29");
    XCTAssertEqualObjects([@"'" urlEncodedString], @"%27");
    XCTAssertEqualObjects([@"," urlEncodedString], @"%2C");
    XCTAssertEqualObjects([@"*" urlEncodedString], @"%2A");
    
    // Letters and numbers
    XCTAssertEqualObjects([@"a" urlEncodedString], @"a");
    XCTAssertEqualObjects([@"Z" urlEncodedString], @"Z");
    XCTAssertEqualObjects([@"0" urlEncodedString], @"0");
    XCTAssertEqualObjects([@"1234567890" urlEncodedString], @"1234567890");
    
    // Non-ASCII characters
    XCTAssertEqualObjects([@"中文" urlEncodedString], @"%E4%B8%AD%E6%96%87");
}

- (void)test_urlDecodedString {
    XCTAssertEqualObjects([@"%E5%88%B7%E6%96%B0%E8%BF%87%E4%BA%8E%E9%A2%91%E7%B9%81%EF%BC%8C%E8%AF%B7%E7%A8%8D%E5%90%8E%E5%86%8D%E8%AF%95" urlDecodedString], @"刷新过于频繁，请稍后再试");
}

#pragma mark - Convert JSON string to NSArray/NSDictionary

- (void)test_jsonObject {
    NSString *jsonDictString = @"{\"result_code\":\"9999\",\"message\":\"ok\",\"conf\":{\"d\":\"E9F8EE6FA52D548711BA59DEFABD948C\",\"switch\":\"1\",\"issync\":\"1\",\"mode\":\"2\",\"infoSwitch\":\"0\"}}";
    NSDictionary *dict = [jsonDictString jsonObject];
    XCTAssertTrue([dict isKindOfClass:[NSDictionary class]]);
    
    NSString *jsonArrayString = @"[{\"id\": \"1\", \"name\":\"Aaa\"}, {\"id\": \"2\", \"name\":\"Bbb\"}]";
    NSArray *arr = [jsonArrayString jsonObject];
    XCTAssertTrue([arr isKindOfClass:[NSArray class]]);
    
    NSString *plainString = @"hello, world]";
    id jsonObject = [plainString jsonObject];
    XCTAssertNil(jsonObject);
}

- (void)test_jsonDict {
    NSString *jsonDictString = @"{\"result_code\":\"9999\",\"message\":\"ok\",\"conf\":{\"d\":\"E9F8EE6FA52D548711BA59DEFABD948C\",\"switch\":\"1\",\"issync\":\"1\",\"mode\":\"2\",\"infoSwitch\":\"0\"}}";
    NSDictionary *dict = [jsonDictString jsonDict];
    XCTAssert([dict isKindOfClass:[NSDictionary class]], @"%@ should be NSDictionary", dict);
    
    NSLog(@"%@", [dict valueForKeyPath:@"result_code"]);
    NSLog(@"%@", [dict valueForKeyPath:@"conf.infoSwitch"]);
    
    NSString *jsonArrayString = @"[{\"id\": \"1\", \"name\":\"Aaa\"}, {\"id\": \"2\", \"name\":\"Bbb\"}]";
    NSDictionary *fakeDict = [jsonArrayString jsonDict];
    XCTAssertNil(fakeDict, @"%@ should be nil", fakeDict);
    
    XCTAssertEqualObjects(@(1), [@"{\"\":true}" jsonDict][@""]);
    XCTAssertEqualObjects(@(0), [@"{\"\":false}" jsonDict][@""]);
    XCTAssertEqualObjects([NSNull null], [@"{\"\":null}" jsonDict][@""]);
}

- (void)test_jsonArray {
    NSString *jsonArrayString = @"[{\"id\": \"1\", \"name\":\"Aaa\"}, {\"id\": \"2\", \"name\":\"Bbb\"}]";
    NSArray *arr = [jsonArrayString jsonArray];
    XCTAssert([arr isKindOfClass:[NSArray class]], @"%@ should be NSArray", arr);
    
    NSString *jsonDictString = @"{\"result_code\":\"9999\",\"message\":\"ok\",\"conf\":{\"d\":\"E9F8EE6FA52D548711BA59DEFABD948C\",\"switch\":\"1\",\"issync\":\"1\",\"mode\":\"2\",\"infoSwitch\":\"0\"}}";
    NSArray *fakedArr = [jsonDictString jsonArray];
    XCTAssertNil(fakedArr, @"%@ should be nil", fakedArr);
}

#pragma mark - Convert NSString to JSON string

- (void)test_jsonEscapedString {
    NSString *s = @"It's \"Tom\".\n"; // the original string is `It's "Tom".\n` in memory
    XCTAssertEqualObjects([s jsonEscapedString], @"It's \\\"Tom\\\".\\n");
}

#pragma mark -

- (void)test_collapsedStringWithCharacters {
    
    // Omit spaces
    NSString *testString1 = @"  Hello      this  is a   long       string!   ";
    NSLog(@"\"%@\"", [testString1 collapsedStringWithCharacters:@" "]);
    NSLog(@"-----------------------------");
    
    //
    NSString *testString2 = @"\n\n\nHello\t\t\tthis is a   long       string!   ";
    NSLog(@"\"%@\"", [testString2 collapsedStringWithCharacters:@" \n\t"]);
    NSLog(@"-----------------------------");
    
    NSString *testString3 = @"😄😄😄😄Hello    😂😂😂😂this  is a   long😁😁😁😁😁😁       string!   ";
    NSLog(@"\"%@\"", [testString3 collapsedStringWithCharacters:@" 😄😂😁"]);
    NSLog(@"-----------------------------");
    
    NSString *testString4 = @"AAABBCDDDDEEFF";
    NSLog(@"\"%@\"", [testString4 collapsedStringWithCharacters:@"ABCDEf"]);
    NSLog(@"-----------------------------");
}

#pragma mark - Encryption/Decryption

- (void)test_MD5 {
    XCTAssertTrue([@"abc" MD5].length == 32);
    XCTAssertNil([@"" MD5]);
    NSString *nilString = nil;
    XCTAssertNil([nilString MD5]);
    NSLog(@"%@", [@"abc" MD5]);
}

#pragma mark - Generate special strings

- (void)test_randomStringWithLength {
    NSLog(@"random string: %@", [NSString randomStringWithLength:20]);
    NSLog(@"random string: %@", [NSString randomStringWithLength:20]);
    NSLog(@"random string: %@", [NSString randomStringWithLength:40]);
    NSLog(@"random string: %@", [NSString randomStringWithLength:40]);
}

- (void)test_randomStringWithCharacters_length {
    NSString *characters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-_";
    
    NSLog(@"random string: %@", [NSString randomStringWithCharacters:characters length:20]);
    NSLog(@"random string: %@", [NSString randomStringWithCharacters:characters length:20]);
    NSLog(@"random string: %@", [NSString randomStringWithCharacters:characters length:40]);
    NSLog(@"random string: %@", [NSString randomStringWithCharacters:characters length:40]);
}

- (void)test_spacedStringWithFormat {
    
    XCTAssertEqualObjects([@"1234567890" spacedStringWithFormat:@"XXX XXXX XXXX"], @"123 4567 890");
    XCTAssertEqualObjects([@"1234567890" spacedStringWithFormat:@"XXX XXX XXXX"], @"123 456 7890");
    XCTAssertEqualObjects([@"123456789012" spacedStringWithFormat:@"XXX XXXX XXXX"], @"123 4567 89012");
    XCTAssertEqualObjects([@"1234" spacedStringWithFormat:@"XXX XXXX XXXX"], @"123 4");
    XCTAssertEqualObjects([@"123456789012" spacedStringWithFormat:@" X XX XXX"], @" 1 23 456789012");
    XCTAssertEqualObjects([@"abc" spacedStringWithFormat:@" X X X "], @" a b c");
    XCTAssertEqualObjects([@"abcd" spacedStringWithFormat:@" X X X "], @" a b c d");
    XCTAssertEqualObjects([@"abcd" spacedStringWithFormat:@" X X "], @" a b cd");
    
    // abnormal cases
    XCTAssertEqualObjects([@" 1 2 3 4 5 6 7 8 9 0 " spacedStringWithFormat:@"XXX XXXX XXXX"], @"123 4567 890");
    XCTAssertEqualObjects([@" 1 2 3 4 5 6 7 8 9 0 " spacedStringWithFormat:@"ZZZZZZzzzzzzzzzzzzzzzzzzzz"], @"1234567890");
    XCTAssertEqualObjects([@"1234567890" spacedStringWithFormat:@"X"], @"1234567890");
    XCTAssertEqualObjects([@"1234567890" spacedStringWithFormat:@"ZZZZZZzzzzzzzzzzzzzzzzzzzz"], @"1234567890");
    XCTAssertEqualObjects([@"1234567890" spacedStringWithFormat:@""], @"1234567890");
    XCTAssertEqualObjects([@"" spacedStringWithFormat:@""], @"");
    XCTAssertEqualObjects([@"" spacedStringWithFormat:@"123456"], @"");
    XCTAssertEqualObjects([@"" spacedStringWithFormat:@"aa aa"], @"");
    XCTAssertEqualObjects([@"  " spacedStringWithFormat:@"aa aa"], @"");
}

#pragma mark - Check strings

- (void)test_charactersAscendOrDescendWithWidth {
    XCTAssertTrue([@"123" charactersAscendOrDescendWithLength:2]);
    XCTAssertTrue([@"324" charactersAscendOrDescendWithLength:2]);
    XCTAssertTrue([@"123456" charactersAscendOrDescendWithLength:5]);
    XCTAssertTrue([@"abcdefg" charactersAscendOrDescendWithLength:7]);
    XCTAssertTrue([@"gfedcba" charactersAscendOrDescendWithLength:7]);
    XCTAssertFalse([@"gfedcba" charactersAscendOrDescendWithLength:8]);
    XCTAssertFalse([@"123123" charactersAscendOrDescendWithLength:5]);
}

- (void)test_uniformedBySingleCharacter {
    XCTAssertTrue([@"" uniformedBySingleCharacter]);
    XCTAssertTrue([@"a" uniformedBySingleCharacter]);
    XCTAssertTrue([@"aaaaaaaaa" uniformedBySingleCharacter]);
    XCTAssertTrue([@"😁😁😁😁" uniformedBySingleCharacter]);
    XCTAssertTrue([@"\n\n\n\n\n" uniformedBySingleCharacter]);
    XCTAssertTrue([@"        " uniformedBySingleCharacter]);
    XCTAssertTrue([@"9999999999" uniformedBySingleCharacter]);
    XCTAssertTrue([@"0" uniformedBySingleCharacter]);
    
    NSString *nilString = nil;
    XCTAssertFalse([nilString uniformedBySingleCharacter]);
    XCTAssertFalse([@"aaaaz" uniformedBySingleCharacter]);
    XCTAssertFalse([@"\t\n\t\t" uniformedBySingleCharacter]);
    XCTAssertFalse([@"😁😂" uniformedBySingleCharacter]);
}

- (void)test_noneNegativeInteger {
    XCTAssertFalse([@"" noneNegativeInteger]);
    XCTAssertFalse([@"110abc" noneNegativeInteger]);
    XCTAssertFalse([@"110\n" noneNegativeInteger]);
    XCTAssertFalse([@"110 " noneNegativeInteger]);
    XCTAssertFalse([@"110.1" noneNegativeInteger]);
    XCTAssertFalse([@".10" noneNegativeInteger]);
    XCTAssertFalse([@"110." noneNegativeInteger]);
    XCTAssertFalse([@"  " noneNegativeInteger]);
    XCTAssertFalse([@"\t" noneNegativeInteger]);
    XCTAssertFalse([@"+1000" noneNegativeInteger]);
    XCTAssertFalse([@"-1000" noneNegativeInteger]);
    XCTAssertFalse([@"010" noneNegativeInteger]);
    XCTAssertFalse([@"000" noneNegativeInteger]);

    XCTAssertTrue([@"0" noneNegativeInteger]);
    XCTAssertTrue([@"10" noneNegativeInteger]);
    XCTAssertTrue([@"123" noneNegativeInteger]);
    XCTAssertTrue([@"10000000000000000000000000000000000000000000000000000000000000000000000000000000" noneNegativeInteger]);
}

- (void)test_positiveInteger {
    XCTAssertFalse([@"0" positiveInteger]);
    XCTAssertFalse([@"" positiveInteger]);
    XCTAssertFalse([@"\n" positiveInteger]);
    XCTAssertFalse([@" " positiveInteger]);
    XCTAssertFalse([@"01" positiveInteger]);
    XCTAssertFalse([@"abc" positiveInteger]);
    XCTAssertFalse([@"\\" positiveInteger]);
    XCTAssertFalse([@"+1" positiveInteger]);
    XCTAssertFalse([@"-1" positiveInteger]);
    XCTAssertFalse([@"1.1" positiveInteger]);
    XCTAssertFalse([@"1." positiveInteger]);
    XCTAssertFalse([@"😂" positiveInteger]);
    NSString *nilString = nil;
    XCTAssertFalse([nilString positiveInteger]);
    
    XCTAssertTrue([@"1" positiveInteger]);
    XCTAssertTrue([@"10" positiveInteger]);
    XCTAssertTrue([@"99999" positiveInteger]);
}

- (void)test_composedOfNumbers {
    XCTAssertFalse([@"abc" composedOfNumbers]);
    XCTAssertFalse([@" " composedOfNumbers]);
    XCTAssertFalse([@"" composedOfNumbers]);
    XCTAssertFalse([@"\t" composedOfNumbers]);
    XCTAssertFalse([@"\\" composedOfNumbers]);
    XCTAssertFalse([@"0ac" composedOfNumbers]);
    XCTAssertFalse([@"a100" composedOfNumbers]);
    XCTAssertFalse([@"-100" composedOfNumbers]);
    XCTAssertFalse([@"+100" composedOfNumbers]);
    XCTAssertFalse([@"1.1" composedOfNumbers]);
    XCTAssertFalse([@"123😂" composedOfNumbers]);
    NSString *nilString = nil;
    XCTAssertFalse([nilString composedOfNumbers]);
    
    XCTAssertTrue([@"0" composedOfNumbers]);
    XCTAssertTrue([@"0001" composedOfNumbers]);
    XCTAssertTrue([@"40" composedOfNumbers]);
    XCTAssertTrue([@"1000000" composedOfNumbers]);
    XCTAssertTrue([@"1001" composedOfNumbers]);
}

- (void)test_composedOfLetters {
    XCTAssertFalse([@"" composedOfLetters]);
    XCTAssertFalse([@" " composedOfLetters]);
    XCTAssertFalse([@"100" composedOfLetters]);
    XCTAssertFalse([@"000" composedOfLetters]);
    XCTAssertFalse([@"0" composedOfLetters]);
    XCTAssertFalse([@"\t" composedOfLetters]);
    XCTAssertFalse([@"abc123" composedOfLetters]);
    XCTAssertFalse([@"123abc" composedOfLetters]);
    XCTAssertFalse([@"abc\n" composedOfLetters]);
    XCTAssertFalse([@"abc " composedOfLetters]);
    XCTAssertFalse([@"abc😂" composedOfLetters]);
    NSString *nilString = nil;
    XCTAssertFalse([nilString composedOfLetters]);
    
    XCTAssertTrue([@"abcABC" composedOfLetters]);
    XCTAssertTrue([@"a" composedOfLetters]);
    XCTAssertTrue([@"A" composedOfLetters]);
    XCTAssertTrue([@"Zz" composedOfLetters]);
    XCTAssertTrue([@"abcdefghijklmnopqrstuvwxyz" composedOfLetters]);
    XCTAssertTrue([@"ABCDEFGHIJKLMNOPQRSTUVWXYZ" composedOfLetters]);
    XCTAssertTrue([@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" composedOfLetters]);
}

- (void)test_composedOfLettersLowercase {
    XCTAssertFalse([@"" composedOfLettersLowercase]);
    XCTAssertFalse([@" " composedOfLettersLowercase]);
    XCTAssertFalse([@"100" composedOfLettersLowercase]);
    XCTAssertFalse([@"000" composedOfLettersLowercase]);
    XCTAssertFalse([@"0" composedOfLettersLowercase]);
    XCTAssertFalse([@"\t" composedOfLettersLowercase]);
    XCTAssertFalse([@"abc123" composedOfLettersLowercase]);
    XCTAssertFalse([@"123abc" composedOfLettersLowercase]);
    XCTAssertFalse([@"abc\n" composedOfLettersLowercase]);
    XCTAssertFalse([@"abc " composedOfLettersLowercase]);
    XCTAssertFalse([@"abc😂" composedOfLettersLowercase]);
    XCTAssertFalse([@"A" composedOfLettersLowercase]);
    XCTAssertFalse([@"Zz" composedOfLettersLowercase]);
    XCTAssertFalse([@"ABCDEFGHIJKLMNOPQRSTUVWXYZ" composedOfLettersLowercase]);
    XCTAssertFalse([@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" composedOfLettersLowercase]);
    NSString *nilString = nil;
    XCTAssertFalse([nilString composedOfLettersLowercase]);
    
    XCTAssertTrue([@"abcdefghijklmnopqrstuvwxyz" composedOfLettersLowercase]);
    XCTAssertTrue([@"a" composedOfLettersLowercase]);
}

- (void)test_composedOfLettersUppercase {
    XCTAssertFalse([@"" composedOfLettersUppercase]);
    XCTAssertFalse([@" " composedOfLettersUppercase]);
    XCTAssertFalse([@"100" composedOfLettersUppercase]);
    XCTAssertFalse([@"000" composedOfLettersUppercase]);
    XCTAssertFalse([@"0" composedOfLettersUppercase]);
    XCTAssertFalse([@"\t" composedOfLettersUppercase]);
    XCTAssertFalse([@"abc123" composedOfLettersUppercase]);
    XCTAssertFalse([@"123abc" composedOfLettersUppercase]);
    XCTAssertFalse([@"abc\n" composedOfLettersUppercase]);
    XCTAssertFalse([@"abc " composedOfLettersUppercase]);
    XCTAssertFalse([@"abc😂" composedOfLettersUppercase]);
    XCTAssertFalse([@"abcABC" composedOfLettersUppercase]);
    XCTAssertFalse([@"a" composedOfLettersUppercase]);
    XCTAssertFalse([@"Zz" composedOfLettersUppercase]);
    XCTAssertFalse([@"abcdefghijklmnopqrstuvwxyz" composedOfLettersUppercase]);
    XCTAssertFalse([@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" composedOfLettersUppercase]);
    
    NSString *nilString = nil;
    XCTAssertFalse([nilString composedOfLettersUppercase]);
    
    XCTAssertTrue([@"A" composedOfLettersUppercase]);
    XCTAssertTrue([@"ABCDEFGHIJKLMNOPQRSTUVWXYZ" composedOfLettersUppercase]);
}

- (void)test_composedOfChineseCharacters {
    XCTAssertFalse([@"" composedOfChineseCharacters]);
    XCTAssertFalse([@"a中" composedOfChineseCharacters]);
    XCTAssertFalse([@"中a" composedOfChineseCharacters]);
    XCTAssertFalse([@"中 文" composedOfChineseCharacters]);
    XCTAssertFalse([@"、中文" composedOfChineseCharacters]);
    XCTAssertFalse([@"中文\b" composedOfChineseCharacters]);
    XCTAssertFalse([@"中文😂" composedOfChineseCharacters]);
    NSString *nilString = nil;
    XCTAssertFalse([nilString composedOfChineseCharacters]);
    XCTAssertFalse([@" " composedOfChineseCharacters]);
    
    XCTAssertTrue([@"中文" composedOfChineseCharacters]);
    XCTAssertTrue([@"中" composedOfChineseCharacters]);
    XCTAssertTrue([@"中文是中国汉字" composedOfChineseCharacters]);
}

- (void)test_alphanumeric {
    XCTAssertTrue([@"abc" alphanumeric]);
    XCTAssertTrue([@"ABC" alphanumeric]);
    XCTAssertTrue([@"abc123" alphanumeric]);
    XCTAssertTrue([@"ABC123" alphanumeric]);
    XCTAssertTrue([@"abcABC" alphanumeric]);
    XCTAssertTrue([@"abcABC123" alphanumeric]);
    
    XCTAssertFalse([@"!@#" alphanumeric]);
    XCTAssertFalse([@"" alphanumeric]);
    NSString *nilString = nil;
    XCTAssertFalse([nilString alphanumeric]);
    XCTAssertFalse([@" " alphanumeric]);
    XCTAssertFalse([@"中文" alphanumeric]);
}

#define NSPREDICATE(expression)    ([NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression])

- (void)test {
    NSString *str = @"\u00b7";
    NSLog(@"%@", str);
    NSLog(@"%@", @"·");
    NSLog(@"%@", @"·");
    
    NSString *text = @"你好·哈好·你好";//·你好
    if ([NSPREDICATE(@"^[\u4e00-\u9fa5]{2,5}(?:\u00b7[\u4e00-\u9fa5]{2,5})*$") evaluateWithObject:text]) {
        NSLog(@"pass");
    }
}

#pragma mark - Escape & Unescaped String

- (void)test_unescapedString {
    // Case 1: Need to unescape
    XCTAssertEqualObjects([@"\\u5404\\u500b\\u90fd" unescapedString], @"各個都");
    XCTAssertEqualObjects([@"\\U5378\\U8f7d\\U5e94\\U7528" unescapedString], @"卸载应用");
    XCTAssertEqualObjects([@"\u03C0" unescapedString], @"π");
    
    // Case 2: No need to unescape
    XCTAssertEqualObjects([@"" unescapedString], @"");
    XCTAssertEqualObjects([@"a normal string" unescapedString], @"a normal string");
    NSString *nilString;
    XCTAssertNil([nilString unescapedString]);
}

- (void)test_ulrstring {
//    NSString *s1 = @"g\u2006h";
//    NSData *data = [s1 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *s3 = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
//    
//    NSLog(@"%@", [s1 urlEncodedString]);
//    NSLog(@"%@", [s1 urlEncodedStringWithEncoding:NSUnicodeStringEncoding]);
// 
//    NSString *s2 = @"g h";
//    NSLog(@"%@", [s2 urlEncodedString]);
//    NSLog(@"%@", [s2 urlEncodedStringWithEncoding:NSUTF8StringEncoding]);
    
    
//    NSString *unicodedString = @"😃";
//    NSData *unicodedStringData = [unicodedString dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *emojiStringValue = [[NSString alloc] initWithData:unicodedStringData encoding:NSNonLossyASCIIStringEncoding];
    
    NSString *s1 = @"g\u2006h";
    NSString *s4 = @"g h";
    NSLog(@"%@", [s1 dataUsingEncoding:NSUTF8StringEncoding]);
    NSLog(@"%@", [s4 dataUsingEncoding:NSUTF8StringEncoding]);
    
    NSLog(@"%@", s1);
    NSLog(@"%@", s4);
    
    const char *cString = s1.UTF8String;
    NSData *data = [NSData dataWithBytes:cString length:strlen(cString)];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string: %@", [string dataUsingEncoding:NSASCIIStringEncoding]);
    NSLog(@"%@", [string urlEncodedString]);
    
    NSString *space1 = @"\u2006";
    NSString *space2 = @" ";
//    space2 = @"\u0041";
    
    space1 = [space1 stringByReplacingOccurrencesOfString:@"\u2006" withString:@" "];
    
    if ([space1 isEqualToString:space2]) {
        NSLog(@"equal");
    }
    else {
        NSLog(@"not equal");
    }
    
    NSString *str = @"\u5404\u500b\u90fd";
    NSLog(@"%@", str);
}

#pragma mark - Handle Paths

- (void)test_stringWithPathRelativeTo {
    XCTAssertEqualObjects([@"/a" stringWithPathRelativeTo:@"/"], @"a", @"should equal");
    XCTAssertEqualObjects([@"a/b" stringWithPathRelativeTo:@"a"], @"b", @"");
    XCTAssertEqualObjects([@"a/b/c" stringWithPathRelativeTo:@"a"], @"b/c", @"");
    XCTAssertEqualObjects([@"a/b/c" stringWithPathRelativeTo:@"a/b"], @"c", @"");
    XCTAssertEqualObjects([@"a/b/c" stringWithPathRelativeTo:@"a/d"], @"../b/c", @"");
    XCTAssertEqualObjects([@"a/b/c" stringWithPathRelativeTo:@"a/d/e"], @"../../b/c", @"");
    XCTAssertEqualObjects([@"/a/b/c" stringWithPathRelativeTo:@"/d/e/f"], @"../../../a/b/c", @"");
}

@end


