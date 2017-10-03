//
//  RootViewController.m
//  AppTest
//
//  Created by wesley chen on 15/6/26.
//
//

#import "RootViewController.h"

#import "Demo1ViewController.h"
#import "Demo2ViewController.h"

@interface RootViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *classes;
@end

@implementation RootViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self prepareForInit];
    }
    
    return self;
}

- (void)prepareForInit {
    self.title = @"AppTest";

    // MARK: Configure titles and classes for table view
    _titles = @[
        @"Check transition (push/pop, present/dismiss)",
        @"Present modal VC from right",
    ];
    _classes = @[
        @"Demo1ViewController",
        @"Demo2ViewController",
    ];
}

#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewController:_classes[indexPath.row]];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *sCellIdentifier = @"RootViewController_sCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    cell.textLabel.text = _titles[indexPath.row];

    return cell;
}

- (void)pushViewController:(NSString *)viewControllerClass {
    NSAssert([viewControllerClass isKindOfClass:[NSString class]], @"%@ is not NSString", viewControllerClass);
    
    Class class = NSClassFromString(viewControllerClass);
    if (class && [class isSubclassOfClass:[UIViewController class]]) {
        
        UIViewController *vc = [[class alloc] init];
        vc.title = _titles[[_classes indexOfObject:viewControllerClass]];
        
        if ([viewControllerClass isEqualToString:@"Demo2ViewController"]) {
            // @sa http://stackoverflow.com/questions/8999953/animate-presentmodalviewcontroller-from-right-left
            CATransition *transition = [CATransition animation];
            transition.duration = 0.5;
            transition.duration = 5;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionMoveIn;
            transition.subtype = kCATransitionFromRight;
            [self.view.window.layer addAnimation:transition forKey:nil];
            
            [self.navigationController presentViewController:vc animated:NO completion:nil];
//            [self.navigationController presentModalViewController:vc animated:NO];
        }
        else {
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
