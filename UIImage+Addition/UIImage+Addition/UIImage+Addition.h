//
//  UIImage+Addition.h
//  UIImage+Addition
//
//  Created by wesley chen on 15/7/31.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

#pragma mark - Gernerate Image

+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)imageWithTemplateColor:(UIColor *)templateColor;

#pragma mark - Adjust Image Size

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

- (UIImage *)drawInImage:(UIImage *)parentImage placedAt:(CGRect)frame;
- (UIImage *)imageWithAlpha:(CGFloat)alpha;

+ (UIImage *)imageWithForegroundImage:(UIImage *)foregroundImage backgroundColor:(UIColor *)backgroundColor;

+ (UIImage *)combineImage:(UIImage *)image withBackgroundColor:(UIColor *)bgColor;

+ (UIImage *)createTintedImageFromImage:(UIImage *)originalImage color:(UIColor *)desiredColor;

+ (UIImage *)changeWhiteColorTransparent:(UIImage *)image;

+ (UIImage *)processImage:(UIImage *)image;

@end
