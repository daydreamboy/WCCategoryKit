//
//  UIColor+Addition.h
//  UIColor+Addition
//
//  Created by wesley chen on 15/7/31.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)

#pragma mark - Color Modification
- (UIColor *)colorWithAlpha:(CGFloat)alpha;
+ (UIColor *)randomColor;
+ (UIColor *)randomRGBAColor;
+ (NSArray *)transitionColorsFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor onProgress:(CGFloat)progress;

#pragma mark - Color Convertion

+ (NSString *)RGBHexStringWithColor:(UIColor *)color;
+ (NSString *)RGBAHexStringWithColor:(UIColor *)color;

@end
