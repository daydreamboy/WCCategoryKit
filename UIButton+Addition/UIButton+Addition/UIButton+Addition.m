//
//  UIButton+Addition.m
//  UIButton+Addition
//
//  Created by wesley chen on 16/3/4.
//
//

#import "UIButton+Addition.h"
#import <objc/runtime.h>

@implementation UIButton (Addition)

@dynamic hitTestEdgeInsets;

static const NSString *sHitTestEdgeInsetsObjectTag = @"HitTestEdgeInsets";

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];

    objc_setAssociatedObject(self, &sHitTestEdgeInsetsObjectTag, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &sHitTestEdgeInsetsObjectTag);

    if (value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }
    else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // @sa http://stackoverflow.com/questions/808503/uibutton-making-the-hit-area-larger-than-the-default-hit-area
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero)
        || !self.enabled
        || self.hidden) {
        return [super pointInside:point withEvent:event];
    }

    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);

    return CGRectContainsPoint(hitFrame, point);
}

@end
