//
//  ViewController.m
//  AppTest
//
//  Created by wesley chen on 16/7/12.
//
//

#import "Demo1ViewController.h"
#import "UIViewController+Addition.h"
#import "Demo1ModalViewController.h"
#import "Demo1StackViewController.h"

@interface Demo1ViewController ()
@property (nonatomic, strong) UIButton *buttonPush;
@property (nonatomic, strong) UIButton *buttonPresent;
@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.buttonPush];
    [self.view addSubview:self.buttonPresent];
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

    if ([self appearingDueToDismiss]) {
        NSLog(@"present to appear: YES");
    }
    else {
        NSLog(@"present to appear: NO");
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

    if ([self isBeingPresented]) {
        NSLog(@"present to appear: YES");
    }
    else {
        NSLog(@"present to appear: NO");
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

#pragma mark - Getters

- (UIButton *)buttonPush {
    if (!_buttonPush) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat width = 140.0f;
        CGFloat height = 30.0f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((screenSize.width - width) / 2.0, 120, width, height);
        button.layer.cornerRadius = 4.0f;
        button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        button.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        button.layer.masksToBounds = YES;
        [button setTitle:@"Push" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPushClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _buttonPush = button;
    }
    
    return _buttonPush;
}

- (UIButton *)buttonPresent {
    if (!_buttonPresent) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat width = 140.0f;
        CGFloat height = 30.0f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((screenSize.width - width) / 2.0, CGRectGetMaxY(self.buttonPush.frame) + 10, width, height);
        button.layer.cornerRadius = 4.0f;
        button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        button.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        button.layer.masksToBounds = YES;
        [button setTitle:@"Present" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPresentClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _buttonPresent = button;
    }
    
    return _buttonPresent;
}

#pragma mark - Actions

- (void)buttonPushClicked:(id)sender {
    [self.navigationController pushViewController:[Demo1StackViewController new] animated:YES];
}

- (void)buttonPresentClicked:(id)sender {
    [self.navigationController presentViewController:[Demo1ModalViewController new] animated:YES completion:nil];
}

@end
