//
//  UIResponder+Addition.m
//  UIResponder+Addition
//
//  Created by wesley chen on 16/3/8.
//
//

#import "UIResponder+Addition.h"

static __weak id currentFirstResponder;

@implementation UIResponder (Addition)

+ (id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
