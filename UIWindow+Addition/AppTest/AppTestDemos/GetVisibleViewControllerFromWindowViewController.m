//
//  GetVisibleViewControllerFromWindowViewController.m
//  AppTest
//
//  Created by wesley_chen on 30/10/2017.
//  Copyright © 2017 wesley_chen. All rights reserved.
//

#import "GetVisibleViewControllerFromWindowViewController.h"
#import "UIWindow+Addition.h"

@interface GetVisibleViewControllerFromWindowViewController ()

@end

@implementation GetVisibleViewControllerFromWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIViewController *vc = [[[UIApplication sharedApplication].delegate window] visibleViewController];
    if (vc) {
        NSLog(@"visible view controller: %@", vc);
    }
    else {
        NSLog(@"not found visible view controller");
    }
}

@end
