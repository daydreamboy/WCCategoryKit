//
//  UIViewController+Addition.h
//  UIViewController+Addition
//
//  Created by wesley chen on 16/7/12.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (Addition)

#pragma mark - Status

- (BOOL)isVisible;

+ (UIViewController *)rootViewController;

#pragma mark - Check transition (e.g. push/pop, present/dismiss)

// Check push/pop stack view controller
- (BOOL)appearingDueToPushed;
- (BOOL)disappearingDueToPopped;

// Check present/dismiss modal view controller
- (BOOL)appearingDueToDismiss;
- (BOOL)disappearingDueToPresent;

@end
