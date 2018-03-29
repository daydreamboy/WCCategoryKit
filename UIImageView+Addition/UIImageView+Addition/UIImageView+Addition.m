//
//  UIImageView+Addition.m
//  AppTest
//
//  Created by wesley_chen on 29/03/2018.
//

#import "UIImageView+Addition.h"

@implementation UIImageView (Addition)

@end


@implementation UIImageView (ShadowBorder)

- (void)addShadowBorderWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    if (!self.image) {
        NSLog(@"%@'s image is nil", self);
        return;
    }
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    imageLayer.contents = (id)self.image.CGImage;
    imageLayer.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    //
    imageLayer.shadowColor = [UIColor redColor].CGColor;
    imageLayer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    imageLayer.shadowOpacity = 1.0f;
    //        imageLayer.borderWidth = 1.0;
    imageLayer.shadowRadius = 2.0f;
    
    [self.layer addSublayer:imageLayer];
}

@end
