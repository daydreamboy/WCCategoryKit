//
//  UIView+Debug.m
//  UIView+Addition
//
//  Created by wesley chen on 15/8/9.
//
//

#import "UIView+Debug.h"

@implementation UIView (Debug)

/*!
 *  Print recursive description of its all subviews, including itself
 *
 *  @sa http://www.raywenderlich.com/62435/make-swipeable-table-view-cell-actions-without-going-nuts-scroll-views
 *  @warning Only available in debug mode which is DEBUG macro is enabled
 */
- (void)hierarchalDescription {
    // Note: recursiveDescription is a private method, disabled in release mode
#if DEBUG
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSLog(@"hierarchalDescription:\n\n%@", [self performSelector:NSSelectorFromString(@"recursiveDescription")]);
#pragma GCC diagnostic pop
    
#endif
}

@end
