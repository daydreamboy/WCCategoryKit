//
//  NSString+OpenSSL.m
//  NSString+Addition
//
//  Created by wesley chen on 16/3/20.
//
//

#import "NSString+OpenSSL.h"

#import <openssl/rsa.h>
#import <openssl/pem.h>
#import <openssl/err.h>

@implementation NSString (OpenSSL)

/*!
 *  Encrypt plain string with public key
 *
 *  @param publicKey the public key being formated every lines of 64 chars with '\n'
 *
 *  @return the base64-encoded string with one line. If nil, the encryption failed.
 *
 *  @warning <br/> 1. Don't encrypt a large data
 *           <br/> 2. the publicKey key must be formated every lines of 64 chars with '\n'
 *
 *  @sa http://doginthehat.com.au/2014/04/basic-openssl-rsa-encryptdecrypt-example-in-cocoa/
 *  @note http://stackoverflow.com/questions/19344122/how-to-encrypt-decrypt-long-input-messages-with-rsa-openssl-c
 */
- (NSString *)encryptedStringWithPublicKey:(NSString *)publicKey {
    
    const char *pubKey = [publicKey UTF8String];
    
    BIO *bio = BIO_new_mem_buf((void *)pubKey, (int)strlen(pubKey));
    RSA *rsa_publickey = PEM_read_bio_RSA_PUBKEY(bio, NULL, 0, NULL);
    BIO_free(bio);
    
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    // Allocate a buffer
    int maxSize = RSA_size(rsa_publickey);
    unsigned char *output = (unsigned char *)malloc(maxSize * sizeof(char));
    
    // Fill buffer with encrypted data
    int numberOfBytes = RSA_public_encrypt((int)[plainData length], [plainData bytes], output, rsa_publickey, RSA_PKCS1_PADDING);
    
    if (numberOfBytes == -1 ) {
        printf("%s\n", ERR_error_string(ERR_get_error(), NULL));
        return nil;
    }
    
    NSData *encryptedData = [NSData dataWithBytes:output length:numberOfBytes];
    
    free(output);
    
    NSString *encrptedString = [[NSString alloc] initWithData:[encryptedData base64EncodedDataWithOptions:0] encoding:NSUTF8StringEncoding];
    return encrptedString;
}

/*!
 *  Decrypt encryped string formated by base64-encoding with private key
 *
 *  @param privateKey the private key being formated every lines of 64 chars with '\n'
 *
 *  @return the base64-encoded string. If nil, the decryption failed.
 *
 *  @warning <br/> 1. Don't encrypt a large data
 *           <br/> 2. the private key must be formated every lines of 64 chars with '\n'
 *
 *  @sa http://doginthehat.com.au/2014/04/basic-openssl-rsa-encryptdecrypt-example-in-cocoa/
 *  @note http://stackoverflow.com/questions/19344122/how-to-encrypt-decrypt-long-input-messages-with-rsa-openssl-c
 */
- (NSString *)decryptedStringWithPrivateKey:(NSString *)privateKey {
    
    const char *priKey = [privateKey UTF8String];
    
    BIO *bio = BIO_new_mem_buf((void *)priKey, (int)strlen(priKey));
    RSA *rsa_privatekey = PEM_read_bio_RSAPrivateKey(bio, NULL, 0, NULL);
    BIO_free(bio);
    
    NSData *encrptedData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    int maxSize = RSA_size(rsa_privatekey);
    unsigned char *output = (unsigned char *)malloc(maxSize * sizeof(char));
    
    // Fill buffer with decrypted data
    int numberOfBytes = RSA_private_decrypt((int)[encrptedData length], [encrptedData bytes], output, rsa_privatekey, RSA_PKCS1_PADDING);
    if (numberOfBytes == -1 ) {
        printf("%s\n", ERR_error_string(ERR_get_error(), NULL));
        return nil;
    }
    
    NSData *plainData = [NSData dataWithBytes:output length:numberOfBytes];
    
    free(output);
    
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    return plainString;
}

@end
