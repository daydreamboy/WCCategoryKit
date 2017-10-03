//
//  NSData+Addition.h
//  NSData+Addition
//
//  Created by wesley chen on 15/8/1.
//
//

#import <Foundation/Foundation.h>

/*!
 *  @sa http://stackoverflow.com/questions/1400246/aes-encryption-for-an-nsstring-on-the-iphone
 *  @sa http://pastie.org/426530#5,37
 */
@interface NSData (Addition)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

#pragma mark - Generate Special Data

+ (NSData *)randomDataWithLength:(NSUInteger)length;

@end
