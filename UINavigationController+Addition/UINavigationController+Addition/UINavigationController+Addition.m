//
//  UINavigationController+Addition.m
//  UINavigationController+Addition
//
//  Created by wesley chen on 16/7/12.
//
//

#import "UINavigationController+Addition.h"

#import <QuartzCore/QuartzCore.h>

@implementation UINavigationController (Addition)

// @sa http://stackoverflow.com/questions/9906966/completion-handler-for-uinavigationcontroller-pushviewcontrolleranimated
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
//    self.delegate = self;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// @sa http://stackoverflow.com/questions/12904410/completion-block-for-popviewcontroller
- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    UIViewController *viewController;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    viewController = [self popViewControllerAnimated:animated];
    [CATransaction commit];
    
    return viewController;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    NSArray *viewControllers;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    viewControllers = [self popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    
    return viewControllers;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    NSArray *viewControllers;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    viewControllers = [self popToViewController:viewController animated:animated];
    [CATransaction commit];
    
    return viewControllers;
}

@end
