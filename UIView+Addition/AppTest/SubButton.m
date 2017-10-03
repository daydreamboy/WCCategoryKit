//
//  SubButton.m
//  UIView+Addition
//
//  Created by wesley chen on 15/6/26.
//
//

#import "SubButton.h"

@implementation SubButton

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    NSLog(@"_cmd: %@", NSStringFromSelector(_cmd));
}

@end
