//
//  Demo1ModalViewController.h
//  UINavigationController+Addition
//
//  Created by wesley chen on 16/8/19.
//
//

#import <UIKit/UIKit.h>

@class Demo1ModalViewController;

@protocol Demo1ModalViewControllerDelegate <NSObject>

- (void)Demo1ModalViewControllerDidDismiss:(Demo1ModalViewController *)viewController;

@end

@interface Demo1ModalViewController : UIViewController

@property (nonatomic, weak) id<Demo1ModalViewControllerDelegate> delegate;

@end
