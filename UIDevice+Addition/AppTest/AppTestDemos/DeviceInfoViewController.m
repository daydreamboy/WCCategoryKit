//
//  DeviceInfoViewController.m
//  AppTest
//
//  Created by wesley_chen on 08/02/2018.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import "DeviceInfoViewController.h"
#import "UIDevice+Addition.h"

@interface DeviceInfoViewController ()
@property (nonatomic, strong) NSArray *titles;
@end

@implementation DeviceInfoViewController

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
                [UIDevice deviceDetailedInfo],
                [UIDevice deviceTypeFormatted:YES],
                [UIDevice deviceTypeFormatted:NO],
                [UIDevice deviceName],
                [UIDevice deviceModel],
                [UIDevice deviceLocalizedModel],
                [UIDevice systemName],
                [UIDevice systemVersion],
                ];
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
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}

@end
