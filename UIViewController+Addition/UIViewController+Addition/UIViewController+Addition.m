//
//  UIViewController+Addition.m
//  UIViewController+Addition
//
//  Created by wesley chen on 16/7/12.
//
//

#import "UIViewController+Addition.h"

@implementation UIViewController (Addition)

/*!
 *  Tell current UIViewController.view is visible
 *
 *  @sa http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
 */
- (BOOL)isVisible {
    return [self isViewLoaded] && self.view.window;
}

/*!
 *  Tell current UIViewController will appear caused by pushed itself or by popping another VC
 *
 *  @return     If YES, it will appear caused by pushing itself. <br/> If NO, it will appear caused by popping another VC.
 *  @warning    This method returns YES only when called from inside the viewWillAppear: and viewDidAppear: methods.
 *  @sa http://stackoverflow.com/questions/13226318/ios-how-do-i-know-the-controller-is-a-push-or-pop-returned
 */
- (BOOL)appearingDueToPushed {
    if (self.navigationController) {
        return self.isMovingToParentViewController;
    }
    else {
        return NO;
    }
}

/*!
 *  Tell current UIViewController will disappear caused by popped itself or by pushing another VC
 *
 *  @return     If YES, it will disappear caused by pushing another VC. <br/> If NO, it will appear caused by popping itself.
 *  @warning    This method returns YES only when called from inside the viewWillDisappear: and viewDidDisappear: methods.
 */
- (BOOL)disappearingDueToPopped {
    if (self.navigationController) {
        return self.isMovingFromParentViewController;
    }
    else {
        return NO;
    }
}

/*!
 *  <#Description#>
 *
 *  @return
 *  @warning This method only available is viewWillDisappear:
 */
- (BOOL)appearingDueToDismiss {
    if (self.presentedViewController) {
        return YES;
    }
    else {
        return NO;
    }
}

/*!
 *  <#Description#>
 *
 *  @return
 *  @warning This method only available is viewWillDisappear: or viewDidDisappear:
 */
- (BOOL)disappearingDueToPresent {
    if (self.presentedViewController) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - UIViewController

/*!
 *  Get the root view controller from UINavigationController
 *
 *  @return If nil, there's no root view controller
 */
+ (UIViewController *)rootViewController {
    
    UIViewController *rootViewController;
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        NSArray *viewControllers = [(UINavigationController *)self viewControllers];
        
        if (viewControllers.count > 0) {
            rootViewController = viewControllers[0];
        }
    }
    
    return rootViewController;
}

@end
