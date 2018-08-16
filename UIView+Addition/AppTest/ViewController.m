//
//  ViewController.m
//  AppTest
//
//  Created by wesley chen on 15/6/25.
//
//

#import "ViewController.h"
#import "UIView+Addition.h"
#import "SubButton.h"
#import "UIView+Debug.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 30)];
    label.text = @"测试";
    [self.view addSubview:label];
    
    SubButton *button = [SubButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 80, 200, 20);
    [button setTitle:@"Press Me" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UISwitch *switcher = [[UISwitch alloc] initWithFrame:CGRectMake(10, 100, 0, 0)];
    [switcher addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    [switcher sizeToFit];
    [self.view addSubview:switcher];
    
    [self.view hierarchalDescription];
    
    
}

@end
