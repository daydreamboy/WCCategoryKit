//
//  Demo1InputViewController.m
//  UINavigationController+Addition
//
//  Created by wesley chen on 16/8/19.
//
//

#import "Demo1InputViewController.h"

@interface Demo1InputViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation Demo1InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, screenSize.width, 30)];
    textField.layer.cornerRadius = 2.0f;
    textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textField.placeholder = @"Type here...";
    
    [self.view addSubview:textField];
    self.textField = textField;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

@end
