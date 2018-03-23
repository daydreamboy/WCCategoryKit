//
//  RootViewController.m
//  AppTest
//
//  Created by wesley chen on 15/6/26.
//
//

#import "RootViewController.h"

#import "DeviceInfoViewController.h"
#import "ProcessorInfoViewController.h"
#import "MemoryInfoViewController.h"
#import "WCDeviceTool.h"

@interface RootViewController ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *classes;
@property (nonatomic, strong) UILabel *labelStatus;
@property (nonatomic, strong) NSTimer *timer;
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
        @"Device Info",
        @"Processor Info",
        @"Memory Info",
        @"malloc 10MB manually",
    ];
    _classes = @[
        [DeviceInfoViewController class],
        [ProcessorInfoViewController class],
        [MemoryInfoViewController class],
        @"malloc10MB",
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[UIApplication sharedApplication].keyWindow addSubview:self.labelStatus];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(queryMemory:) userInfo:nil repeats:YES];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark -

- (void)queryMemory:(NSTimer *)timer {
    double footprint = [WCDeviceTool processMemoryFootprint];
    double president = [WCDeviceTool processMemoryResident];
    self.labelStatus.text = [NSString stringWithFormat:@"footprint: %f, president: %f", footprint, president];
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

    if ([_classes[indexPath.row] isKindOfClass:[NSString class]]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = _titles[indexPath.row];

    return cell;
}

- (void)pushViewController:(id)viewControllerClass {
    
    id class = viewControllerClass;
    if ([class isKindOfClass:[NSString class]]) {
        SEL selector = NSSelectorFromString(viewControllerClass);
        if ([self respondsToSelector:selector]) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector];
#pragma GCC diagnostic pop
        }
        else {
            NSAssert(NO, @"can't handle selector `%@`", viewControllerClass);
        }
    }
    else if (class && [class isSubclassOfClass:[UIViewController class]]) {
        UIViewController *vc = [[class alloc] init];
        vc.title = _titles[[_classes indexOfObject:viewControllerClass]];
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Test Methods

- (void)malloc10MB {
    NSLog(@"malloc 10MB memory");
    
    static BOOL isAlloc = NO;
    static int *bytes = NULL;
    if (!isAlloc) {
//        isAlloc = YES;
        bytes = (int *)malloc(10 * 1024 * 1024);
        int size = 10 * 1024 * 1024 / 4;
        for (int i = 0 ; i < size; i++) {
            bytes[i] = 3;
        }
    }
}

#pragma mark - Getters

- (UILabel *)labelStatus {
    if (!_labelStatus) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 20, screenSize.width, 30);
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blueColor];
        
        _labelStatus = label;
    }
    
    return _labelStatus;
}

@end
