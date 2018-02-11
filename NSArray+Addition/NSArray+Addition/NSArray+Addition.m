//
//  NSArray+Addition.m
//  NSArray+Addition
//
//  Created by wesley chen on 15/4/11.
//
//

#import "NSArray+Addition.h"

#define DEBUG_LOG 0

@implementation NSArray (Addition)

// http://stackoverflow.com/questions/6179427/objective-c-get-a-class-property-from-string
// http://stackoverflow.com/questions/7491805/nsarray-remove-objects-with-duplicate-properties
// http://stackoverflow.com/questions/2941596/nsarray-containobjects-method
- (NSArray *)collapsedArrayWithKeyPaths:(NSArray *)keyPaths {
    
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self];
    
    if (keyPaths) {
        
        
        return arrM;
    }
    else {
        NSMutableArray *uniqueArrM = [NSMutableArray array];
        
        for (id object in self) {
            if (![uniqueArrM containsObject:object]) {
                [uniqueArrM addObject:object];
            }
        }
        
        return uniqueArrM;
    }
}

/**
 *  Get an array of letters with uppercase or lowercase
 *
 *  @param isUppercase YES, uppercase or NO, lowercase
 *
 *  @note the array of letters can be used as index
 *  @return the array of letters
 */
+ (NSArray *)arrayWithLetters:(BOOL)isUppercase {
    if (isUppercase) {
        static NSArray *uppercaseLetters;
        if (!uppercaseLetters) {
            uppercaseLetters = [@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" componentsSeparatedByString:@" "];
        }
        return uppercaseLetters;
    }
    else {
        static NSArray *lowercaseLetters;
        if (!lowercaseLetters) {
            lowercaseLetters = [@"a b c d e f g h i j k l m n o p q r s t u v w x y z" componentsSeparatedByString:@" "];
        }
        return lowercaseLetters;
    }
}

@end

