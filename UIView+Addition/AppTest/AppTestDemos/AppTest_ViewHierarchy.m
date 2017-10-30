//
//  AppTest_ViewHierarchy.m
//  UIView+Addition
//
//  Created by wesley chen on 16/4/8.
//
//

#import "AppTest_ViewHierarchy.h"

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "UIView+ViewHierarchy.h"
#import "UIView+Debug.h"

@implementation AppTest_ViewHierarchy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    id currentViewController = [self.view holdingViewController];
//    NSLog(@"self: %@, viewController: %@", self, currentViewController);
//    NSAssert(self == currentViewController, @"check here");
//    
//    id navController = [self.navigationController.navigationBar holdingViewController];
//    NSLog(@"self.navigationController: %@, %@", self.navigationController, navController);
//    NSAssert(self.navigationController == navController, @"check here");
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    id notAViewController = [window holdingViewController];
    NSAssert(notAViewController == nil, @"check here");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // be careful when view hierarchy is changing (addSubview or removeFromSuperview...)
    __block  BOOL hasCalled = NO;
    [self.view enumerateSubviewsUsingBlock:^(UIView *subview, BOOL *stop) {
        NSLog(@"%@", subview);
        hasCalled = YES;
    }];
    
    if (!hasCalled) {
        NSLog(@"self.view has no subviews");
    }
    
    __block NSUInteger count = 0;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.window enumerateSubviewsUsingBlock:^(UIView *subview, BOOL *stop) {
        NSLog(@"%@", subview);
        count++;
    }];
    
    NSLog(@"=====================================");
    [appDelegate.window enumerateSubviewsUsingBlock:^(UIView *subview, BOOL *stop) {
        NSLog(@"%@", subview);
        if (subview == self.view) {
            NSLog(@"found self.view");
            *stop = YES;
        }
    }];
    
//    NSUInteger numberOfSubviews = ;
//    NSAssert(count == numberOfSubviews, @"%@ is not equal to %@", @(count), @(numberOfSubviews));
    
//    [appDelegate.window hierarchalDescription];
}

@end
