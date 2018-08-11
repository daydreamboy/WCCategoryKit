//
//  WCImageTool.h
//  Test
//
//  Created by wesley_chen on 2018/5/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WCImageTool : NSObject

#pragma mark - Image Generation

/*!
 *  Get an image with pure color
 *
 *  @param color the UIColor
 *
 *  @return a UIImage with {1px, 1px} colored by UIColor
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 Get an image with pure color

 @param color the UIColor
 @param size the size
 @return the new image
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 Get a alpha version of UIImage

 @param image the original image
 @param alpha the alpha, which is (0,1)
 @return the new image with alpha
 */
+ (UIImage *)imageWithImage:(UIImage *)image alpha:(CGFloat)alpha;

/**
 Resize UIImage
 
 @param image the orginal image
 @param newSize the size for scale to fit
 @return the new image
 
 @see http://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size;


+ (UIImage *)drawImage:(UIImage *)image inParentImage:(UIImage *)parentImage placedAt:(CGRect)frame;

#pragma mark - Image Modify

+ (UIImage *)imageWithImage:(UIImage *)image templateColor:(UIColor *)templateColor;
+ (UIImage *)setImage:(UIImage *)image replaceColorComponents:(CGFloat[6])components toColor:(UIColor *)color;

#pragma mark - Image Access

+ (NSURL *)PNGImageURLWithImageName:(NSString *)imageName inResourceBundle:(NSString *)resourceBundleName;

@end
