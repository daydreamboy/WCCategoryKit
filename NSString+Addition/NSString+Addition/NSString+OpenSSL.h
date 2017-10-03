//
//  NSString+OpenSSL.h
//  NSString+Addition
//
//  Created by wesley chen on 16/3/20.
//
//

#import <Foundation/Foundation.h>

@interface NSString (OpenSSL)

- (NSString *)encryptedStringWithPublicKey:(NSString *)publicKey NS_AVAILABLE_IOS(7_0);
- (NSString *)decryptedStringWithPrivateKey:(NSString *)privateKey NS_AVAILABLE_IOS(7_0);

@end
