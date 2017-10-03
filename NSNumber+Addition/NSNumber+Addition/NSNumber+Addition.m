//
//  NSNumber+Addition.m
//  NSNumber+Addition
//
//  Created by wesley chen on 15/4/11.
//
//

#import "NSNumber+Addition.h"

@implementation NSNumber (Addition)

/*!
 *  reference: http://nshipster.cn/nsexpression/
 */
- (NSNumber *)factorial {
    return @(tgamma([self doubleValue] + 1));
}

@end
