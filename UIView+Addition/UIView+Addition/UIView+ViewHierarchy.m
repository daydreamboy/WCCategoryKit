//
//  UIView+ViewHierarchy.m
//  UIView+Addition
//
//  Created by wesley chen on 15/7/16.
//
//

#import "UIView+ViewHierarchy.h"

@implementation UIView (ViewHierarchy)

#pragma mark - Public Methods

/*!
 *  Enumerate all subviews of the UIView, excluding the sender view
 *
 *  @param block the callback
 */
- (void)enumerateSubviewsUsingBlock:(void (^)(UIView *subview, BOOL *stop))block {
    BOOL stop = NO;
    if (block) {
        // Note: pre-travse subviews for root view, so skip the block for root view
        for (UIView *subview in self.subviews) {
            [subview traverseViewHierarchyWithBlock:block stop:&stop];
            if (stop) {
                break;
            }
        }
    }
}

#pragma mark > Internal Methods

/*!
 *  @sa http://stackoverflow.com/questions/2746478/how-can-i-loop-through-all-subviews-of-a-uiview-and-their-subviews-and-their-su
 *  @sa http://stackoverflow.com/questions/7243888/how-to-list-out-all-the-subviews-in-a-uiviewcontroller-in-ios
 *  @sa https://stackoverflow.com/questions/22463017/recursive-method-with-block-and-stop-arguments
 */
- (void)traverseViewHierarchyWithBlock:(void (^)(UIView *subview, BOOL *stop))block stop:(BOOL *)stop {
    NSParameterAssert(block != nil);
    // not use `if (block)` to protect, because it maybe consumes more time when recursion
    block(self, stop);
    
    if (*stop) {
        return;
    }
    
    for (UIView *subview in self.subviews) {
        [subview traverseViewHierarchyWithBlock:block stop:stop];
        if (*stop) {
            break;
        }
    }
}

/*!
 *  Check it and itself all ancestor views `isKindOfClass`
 *
 *  @param cls the Class type wanted to search
 *
 *  @return YES, if found its first ancestor view belong to cls. <br/>NO, if all ancestor views not belong to cls
 */
- (BOOL)ancestralViewIsKindOfClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return YES;
    }
    else {
        UIView *view = self.superview;
        while (view && ![view isKindOfClass:cls]) {
            view = view.superview;
        }
        if ([view isKindOfClass:cls]) {
            return YES;
        }
        return NO;
    }
}

/*!
 *  Get the UIViewController holds the receiver UIView directly or indirectly (that's its super or super... view is self.view)
 *
 *  @return If nil, the receiver UIView has no UIViewController to holding it.
 *
 *  @sa http://stackoverflow.com/questions/1372977/given-a-view-how-do-i-get-its-viewcontroller
 */
- (UIViewController *)holdingViewController {
    UIResponder *responder = self;

    while ([responder isKindOfClass:[UIView class]]) {
        // @note about nextResponder from apple doc:
        // UIView implements this method by returning the UIViewController object that manages it (if it has one) or its superview (if it doesn’t);
        // UIViewController implements the method by returning its view’s superview;
        // UIWindow returns the application object;
        // UIApplication returns nil.
        responder = [responder nextResponder];
    }
    
    if ([responder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)responder;
    }
    else {
        return nil;
    }
}

@end
