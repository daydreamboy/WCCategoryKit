//
//  UIImage+Addition.m
//  UIImage+Addition
//
//  Created by wesley chen on 15/7/31.
//
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)

/*!
 *  Get an image with pure color
 *
 *  @param color the UIColor
 *
 *  @return a UIImage colored by UIColor
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


/**
 Get an image with template color

 @param templateColor the template color which is a pure color
 @return an image which is a template shadow applied with template color
 */
- (UIImage *)imageWithTemplateColor:(UIColor *)templateColor {
    UIImage *newImage = [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIGraphicsBeginImageContextWithOptions(newImage.size, NO, newImage.scale);
    [templateColor set];
    [newImage drawInRect:CGRectMake(0, 0, newImage.size.width, newImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*!
 *  Resize UIImage
 *
 *  @param image   the old image
 *  @param newSize the size to scale
 *
 *  @sa http://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
 *  @return
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    // Avoid redundant drawing
    if (CGSizeEqualToSize(image.size, newSize)) {
        return image;
    }
    
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*!
 *  Place a UIImage in another UIImage
 *
 *  @param parentImage the parent image
 *  @param frame       the frame of new image
 *
 *  @return
 */
- (UIImage *)drawInImage:(UIImage *)parentImage placedAt:(CGRect)frame {
    UIGraphicsBeginImageContextWithOptions(parentImage.size, NO, 0.0);
    
    [parentImage drawInRect:CGRectMake(0, 0, parentImage.size.width, parentImage.size.height)];
    [self drawInRect:frame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return newImage;
}

/*!
 *  Get a alpha version of UIImage
 *
 *  @param alpha the value is [0,1]
 *
 *  @return
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha {
    
    if (alpha >= 1.0 || alpha < 0.0) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

// @sa http://stackoverflow.com/a/16729926/4794665
+ (UIImage *)imageWithForegroundImage:(UIImage *)foregroundImage backgroundColor:(UIColor *)backgroundColor {
    
    CGRect rect = CGRectMake(0, 0, foregroundImage.size.width, foregroundImage.size.height);
    
    // allocate draw context
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // fill background color firstly
    [backgroundColor setFill];
    CGContextFillRect(context, rect);
    
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    [foregroundImage drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // release context
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)combineImage:(UIImage *)image withBackgroundColor:(UIColor *)bgColor
{
    //  Create rect to fit the PNG image
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    //  Create bitmap contect
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // Draw background first
    
    //  Set background color (will be under the PNG)
    [bgColor setFill];
    
    //  Fill all context with background image
    CGContextFillRect(context, rect);
    
    //  Draw the PNG over the background
    [image drawInRect:rect];
    
    //  Create new image from the context
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    //  Release context
    UIGraphicsEndImageContext();
    
    return img;
}

// @sa http://stackoverflow.com/questions/32822092/how-to-tint-only-one-part-of-the-uiimage-with-alpha-channel-png-replacing-col
+ (UIImage *)createTintedImageFromImage:(UIImage *)originalImage color:(UIColor *)desiredColor {
    CGSize imageSize = originalImage.size;
    CGFloat imageScale = originalImage.scale;
    CGRect contextBounds = CGRectMake(0, 0, imageSize.width, imageSize.height);

    UIGraphicsBeginImageContextWithOptions(imageSize, NO /* not opaque */, imageScale); // 2
    [[UIColor blackColor] setFill]; // 3a
    UIRectFill(contextBounds); // 3b
    [originalImage drawAtPoint:CGPointZero]; // 4
    
    UIImage *imageOverBlack = UIGraphicsGetImageFromCurrentImageContext(); // 5
    CGContextClearRect(UIGraphicsGetCurrentContext(), contextBounds);
    [desiredColor setFill]; // 7a
    UIRectFill(contextBounds); // 7b
    [imageOverBlack drawAtPoint:CGPointZero blendMode:kCGBlendModeMultiply alpha:1]; // 8
    
    [originalImage drawAtPoint:CGPointZero blendMode:kCGBlendModeDestinationIn alpha:1]; // 9
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext(); // 10
    UIGraphicsEndImageContext();

    return finalImage;
}

// @sa http://stackoverflow.com/questions/19443311/how-to-make-one-colour-transparent-in-uiimage
+ (UIImage *)changeWhiteColorTransparent:(UIImage *)image {
    CGImageRef rawImageRef = image.CGImage;
    const CGFloat colorMasking[6] = {
        222, 255, 222, 255, 222, 255
    };

    UIGraphicsBeginImageContext(image.size);
    CGImageRef maskedImageRef = CGImageCreateWithMaskingColors(rawImageRef, colorMasking);
    {
        //if in iPhone
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, image.size.height);
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    }

    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), maskedImageRef);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(maskedImageRef);
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)processImage:(UIImage *)image {
    const CGFloat colorMasking[6] = {
        222, 255, 222, 255, 222, 255
    };
    CGImageRef imageRef = CGImageCreateWithMaskingColors(image.CGImage, colorMasking);
    UIImage *imageB = [UIImage imageWithCGImage:imageRef];

    CGImageRelease(imageRef);
    return imageB;
}

@end
