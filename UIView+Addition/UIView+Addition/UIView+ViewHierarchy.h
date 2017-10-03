//
//  UIView+ViewHierarchy.h
//  UIView+Addition
//
//  Created by wesley chen on 15/7/16.
//
//

#import <UIKit/UIKit.h>

@interface UIView (ViewHierarchy)

- (void)enumerateSubviewsUsingBlock:(void (^)(UIView *subview, BOOL *stop))block;
- (BOOL)ancestralViewIsKindOfClass:(Class)cls;

- (UIViewController *)holdingViewController;

@end
