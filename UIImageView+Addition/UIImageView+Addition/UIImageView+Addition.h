//
//  UIImageView+Addition.h
//  AppTest
//
//  Created by wesley_chen on 29/03/2018.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Addition)

@end


@interface UIImageView (ShadowBorder)
- (void)addShadowBorderWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
