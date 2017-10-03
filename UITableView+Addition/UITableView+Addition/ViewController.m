//
//  ViewController.m
//  UITableView+Addition
//
//  Created by wesley chen on 15/6/13.
//  Copyright (c) 2015年 wesley chen. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+Addition.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, assign) NSUInteger numberOfRows;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height - 200) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor yellowColor];
    tableView.removeRedudantSeparators = YES;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableView.frame) + 20, screenSize.width, 30)];
    [button setTitle:@"reload Data" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.numberOfRows = 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"abcd";
    
    return cell;
}

- (void)buttonClicked:(UIButton *)sender {
    if (self.numberOfRows) {
        self.numberOfRows = 0;
        
        // Case 1: Setted One and Getted One should be same
        /*
        self.tableView.emptyView = [self emptyViewOfTableView];
        NSAssert(self.tableView.emptyView == self.emptyView, @"Should be the same");
        */
        
        // Case 2: Set many times
        self.tableView.emptyView = [self emptyViewOfTableView];
        self.tableView.emptyView = [self emptyViewOfTableView2];
    }
    else {
        self.numberOfRows = 3;
        self.tableView.emptyView = nil;
        NSAssert(self.tableView.emptyView == nil, @"Should be nil");
    }
    
    [self.tableView reloadData];
}

- (UIView *)emptyViewOfTableView {
    if (!self.emptyView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        label.backgroundColor = [UIColor greenColor];
        label.text = @"Empty Content";
        label.textAlignment = NSTextAlignmentCenter;
        self.emptyView = label;
    }
    
    return self.emptyView;
}

// Always return new empty view
- (UIView *)emptyViewOfTableView2 {
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
	label.backgroundColor = [UIColor redColor];
	label.text = @"Empty Content";
	label.textAlignment = NSTextAlignmentCenter;

	return label;
}

@end
