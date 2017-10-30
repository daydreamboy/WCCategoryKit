//
//  UIWindow+Addition.m
//  AppTest
//
//  Created by wesley_chen on 30/10/2017.
//  Copyright © 2017 wesley_chen. All rights reserved.
//

#import "UIWindow+Addition.h"

@implementation UIWindow (Addition)

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = self.rootViewController;
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

// @see https://stackoverflow.com/questions/11637709/get-the-current-displaying-uiviewcontroller-on-the-screen-in-appdelegate-m
+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *)vc) visibleViewController]];
    }
    else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *)vc) selectedViewController]];
    }
    else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        }
        else {
            return vc;
        }
    }
}

@end
