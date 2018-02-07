//
//  ViewController.m
//  AppTest
//
//  Created by wesley chen on 16/4/13.
//
//

#import "AppInfoViewController.h"

#import "UIApplication+Addition.h"

@interface AppInfoViewController ()
@property (nonatomic, strong) NSArray *titles;
@end

@implementation AppInfoViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        [self prepareForInit];
    }
    
    return self;
}

- (void)prepareForInit {
    
    _titles = @[
                [UIApplication appVersion],
                @"TODO",
                ];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *sCellIdentifier = @"AppInfoViewController_sCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sCellIdentifier];
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}
@end
