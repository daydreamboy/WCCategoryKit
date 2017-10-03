//
//  Demo1ModalViewController.m
//  UINavigationController+Addition
//
//  Created by wesley chen on 16/8/19.
//
//

#import "Demo1ModalViewController.h"

@interface Demo1ModalViewController ()
@property (nonatomic, strong) UIButton *buttonAnimated;
@end

@implementation Demo1ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.buttonAnimated];
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

#pragma mark - Actions

- (void)buttonAnimatedClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(Demo1ModalViewControllerDidDismiss:)]) {
            [self.delegate Demo1ModalViewControllerDidDismiss:self];
        }
    }];
}


@end
