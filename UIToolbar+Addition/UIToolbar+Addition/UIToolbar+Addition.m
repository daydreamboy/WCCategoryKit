//
//  UIToolbar+Addition.m
//  UIToolbar+Addition
//
//  Created by wesley chen on 15/6/25.
//
//

#import "UIToolbar+Addition.h"

@implementation UIToolbar (Addition)

/*!
 *  Get the frame of UIBarButtonItem
 *
 *  @param barButtonItem
 *
 *  @sa http://stackoverflow.com/questions/8231737/how-to-determine-position-of-uibarbuttonitem-in-uitoolbar
 *  @sa http://stackoverflow.com/questions/14163099/how-can-i-get-the-frame-of-a-uibarbuttonitem
 *  @warning In iOS 6 and 5, the height of frame (UIButton) is NOT equal to the height of UIToolbar
 *           <br/> In iOS 7+, the height of frame (UIToolbarButton) is equal to the height of UIToolbar, so its origin.y is always 0.
 *
 *  @return Return CGRectZero, if not found the barButtonItem
 */
- (CGRect)frameForBarButtonItem:(UIBarButtonItem *)barButtonItem {
    UIControl *button = nil;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UIControl class]]) {
            for (id target in [(UIControl *)subview allTargets]) {
                if (target == barButtonItem) {
                    button = (UIControl *)subview;
                    break;
                }
            }
            if (button != nil) break;
        }
    }
    
    return button == nil ? CGRectZero : button.frame;
}

@end
