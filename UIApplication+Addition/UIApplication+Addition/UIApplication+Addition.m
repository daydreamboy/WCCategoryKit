//
//  UIApplication+Addition.m
//  UIApplication+Addition
//
//  Created by wesley chen on 16/3/8.
//
//

#import "UIApplication+Addition.h"

@implementation UIApplication (Addition)

/*!
 *  enable/disable user interaction
 *
 *  @param isAllow YES, enable user interaction; NO, disable user interaction
 *
 *  @return If YES, operation is done. If NO, operation is ignored
 *  @warning 
 *  <br/> 1. This method must be paired with YES and NO
 *  <br/> 2. This method doesn't work with third-party keyboard on iOS 8+, when disable user interaction but user still can press key
 */
+ (BOOL)allowUserInteractionEvents:(BOOL)isAllow {
    if (isAllow) {
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            return YES;
        }
    }
    else {
        if (![[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            return YES;
        }
    }
    
    return NO;
}

@end
