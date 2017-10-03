//
//  ViewController.m
//  AppTest
//
//  Created by wesley chen on 16/7/12.
//
//

#import "Demo1ViewController.h"
#import "AppDelegate.h"
#import "UINavigationController+Addition.h"
#import "Demo1InputViewController.h"
#import "Demo1ModalViewController.h"

static NSUInteger count;

@interface Demo1ViewController () <Demo1ModalViewControllerDelegate>
@property (nonatomic, strong) UIButton *buttonAnimated;
@property (nonatomic, strong) UIButton *buttonPush;
@property (nonatomic, strong) UIButton *buttonPop;
@property (nonatomic, strong) UIButton *buttonPopToRoot;
@property (nonatomic, strong) UIButton *buttonPopToSecondVC;
@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"ViewController: %@", @(++count)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.buttonAnimated];
    [self.view addSubview:self.buttonPush];
    [self.view addSubview:self.buttonPop];
    [self.view addSubview:self.buttonPopToRoot];
    [self.view addSubview:self.buttonPopToSecondVC];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%@ viewDidAppear", self.title);
}

#pragma mark - Getters

- (UIButton *)buttonAnimated {
    if (!_buttonAnimated) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat width = 140.0f;
        CGFloat height = 30.0f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((screenSize.width - width) / 2.0, 120, width, height);
        button.layer.cornerRadius = 4.0f;
        button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        button.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        button.layer.masksToBounds = YES;
        [button setTitle:@"Animated: YES" forState:UIControlStateNormal];
        [button setTitle:@"Animated: NO" forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAnimatedClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _buttonAnimated = button;
    }
    
    return _buttonAnimated;
}

- (UIButton *)buttonPush {
    if (!_buttonPush) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat width = 140.0f;
        CGFloat height = 30.0f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((screenSize.width - width) / 2.0, CGRectGetMaxY(self.buttonAnimated.frame) + 10, width, height);
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

- (UIButton *)buttonPop {
    if (!_buttonPop) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat width = 140.0f;
        CGFloat height = 30.0f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((screenSize.width - width) / 2.0, CGRectGetMaxY(self.buttonPush.frame) + 10, width, height);
        button.layer.cornerRadius = 4.0f;
        button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        button.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        button.layer.masksToBounds = YES;
        [button setTitle:@"Pop" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPopClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _buttonPop = button;
    }
    
    return _buttonPop;
}

- (UIButton *)buttonPopToRoot {
    if (!_buttonPopToRoot) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat width = 140.0f;
        CGFloat height = 30.0f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((screenSize.width - width) / 2.0, CGRectGetMaxY(self.buttonPop.frame) + 10, width, height);
        button.layer.cornerRadius = 4.0f;
        button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        button.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        button.layer.masksToBounds = YES;
        [button setTitle:@"Pop To Root" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPopToRootClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _buttonPopToRoot = button;
    }
    
    return _buttonPopToRoot;
}

- (UIButton *)buttonPopToSecondVC {
    if (!_buttonPopToSecondVC) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat width = 140.0f;
        CGFloat height = 30.0f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((screenSize.width - width) / 2.0, CGRectGetMaxY(self.buttonPopToRoot.frame) + 10, width, height);
        button.layer.cornerRadius = 4.0f;
        button.layer.borderColor = [UIColor darkGrayColor].CGColor;
        button.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        button.layer.masksToBounds = YES;
        [button setTitle:@"Pop To Second VC" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPopToSecondVCClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _buttonPopToSecondVC = button;
    }
    
    return _buttonPopToSecondVC;
}

#pragma mark - Actions

- (void)buttonAnimatedClicked:(id)sender {
//    UIButton *button = (UIButton *)sender;
//    button.selected = !button.selected;
    
    Demo1ModalViewController *vc = [Demo1ModalViewController new];
    vc.delegate = self;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)buttonPushClicked:(id)sender {
    /*
    Demo1ViewController *vc = [Demo1ViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController pushViewController:vc animated:!self.buttonAnimated.selected completion:^{
        NSLog(@"push completed: %@", vc);
    }];
     */
    
    Demo1InputViewController *viewController = [Demo1InputViewController new];
    [self.navigationController pushViewController:viewController animated:YES completion:^{
        NSLog(@"push completed: %@", viewController);
    }];
}

- (void)buttonPopClicked:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    __block UIViewController *poppedViewController;
    poppedViewController = [self.navigationController popViewControllerAnimated:!self.buttonAnimated.selected  completion:^{
        NSLog(@"pop completed: %@", poppedViewController);
    }];
}

- (void)buttonPopToRootClicked:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    __block NSArray *poppedViewControllers;
    poppedViewControllers = [self.navigationController popToRootViewControllerAnimated:!self.buttonAnimated.selected  completion:^{
        NSLog(@"pop completed: %@", poppedViewControllers);
    }];
}

- (void)buttonPopToSecondVCClicked:(id)sender {
    NSArray *viewControllers = [self.navigationController viewControllers];
    if (viewControllers.count >= 3) {
        UIViewController *secondViewController = viewControllers[1];
//        [self.navigationController popToViewController:secondViewController animated:YES];
        __block NSArray *poppedViewControllers;
        poppedViewControllers = [self.navigationController popToViewController:secondViewController animated:!self.buttonAnimated.selected completion:^{
            NSLog(@"pop completed: %@", poppedViewControllers);
        }];
    }
}

#pragma mark - Demo1ModalViewControllerDelegate

- (void)Demo1ModalViewControllerDidDismiss:(Demo1ModalViewController *)viewController {
    NSLog(@"#####");
    Demo1InputViewController *vc = [Demo1InputViewController new];
    [self.navigationController pushViewController:vc animated:YES completion:^{
        NSLog(@"push completed: %@", vc);
    }];
}

@end
