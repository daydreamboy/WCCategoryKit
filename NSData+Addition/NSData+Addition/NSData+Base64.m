//
//  NSData+Base64.m
//  WCEncryptor
//
//  Created by wesley chen on 16/3/10.
//
//

#import "NSData+Base64.h"

@implementation NSData (Base64)

- (NSString *)base64EncodedString {
    if ([self respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        return [self base64Encoding];

#pragma GCC diagnostic pop
    }
}

@end
