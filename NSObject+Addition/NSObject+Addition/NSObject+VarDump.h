//
//  NSObject+VarDump.h
//  NSObject+Addition
//
//  Created by wesley chen on 16/4/17.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (VarDump)
@end

@interface NSDictionary (VarDump)
- (NSString *)debugDescription;
@end

@interface NSArray (VarDump)
- (NSString *)debugDescription;
@end

NSString * wc_object_dump(NSObject *object);
