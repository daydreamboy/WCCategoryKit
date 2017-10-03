//
//  UIColor+Addition.h
//  UIColor+Addition
//
//  Created by wesley chen on 15/7/31.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)

- (UIColor *)colorWithAlpha:(CGFloat)alpha;

// Helper
+ (UIColor *)randomColor;
+ (NSArray *)transitionColorsFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor onProgress:(CGFloat)progress;

@end
