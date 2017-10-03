//
//  UINavigationController+Addition.h
//  UINavigationController+Addition
//
//  Created by wesley chen on 16/7/12.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Addition) <UINavigationControllerDelegate>

//@property (nonatomic, strong) NSMutableDictionary *completionsM;

#pragma mark - Pushing and Popping Stack Items with `completion`

// animated:YES, completion called before viewDidAppear
// animated:NO, completion called after viewDidAppear
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

@end
