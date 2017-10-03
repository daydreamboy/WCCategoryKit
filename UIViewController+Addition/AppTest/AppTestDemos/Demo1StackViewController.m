//
//  Demo1StackViewController.m
//  UIViewController+Addition
//
//  Created by wesley chen on 16/7/12.
//
//

#import "Demo1StackViewController.h"
#import "UIViewController+Addition.h"

@implementation Demo1StackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"_cmd: %@", NSStringFromSelector(_cmd));

    if ([self appearingDueToPushed]) {
        NSLog(@"push to appear: YES");
    }
    else {
        NSLog(@"push to appear: NO");
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"_cmd: %@", NSStringFromSelector(_cmd));

    if ([self appearingDueToPushed]) {
        NSLog(@"push to appear: YES");
    }
    else {
        NSLog(@"push to appear: NO");
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"_cmd: %@", NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"_cmd: %@", NSStringFromSelector(_cmd));
}

@end
