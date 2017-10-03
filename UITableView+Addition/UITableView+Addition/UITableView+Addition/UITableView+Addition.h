//
//  UITableView+Addition.h
//  UITableView+Addition
//
//  Created by wesley chen on 15/6/13.
//  Copyright (c) 2015年 wesley chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Addition)

/*!
 *  Set YES to remove separators of empty cells when UITableView's content is not fully filled
 *  <br/> Set NO will not recovery removed separators
 */
@property (nonatomic, assign) BOOL removeRedudantSeparators NS_AVAILABLE_IOS(5_0);
/*!
 *  Associate an empty view to UITableView. If it's origin(0,0) will centered in UITableView, or consider its origin point
 *  <br/> Set empty view when no data
 *  <br/> Set nil when there's data
 */
@property (nonatomic, strong) UIView *emptyView NS_AVAILABLE_IOS(5_0);

- (NSIndexPath *)indexPathForRowContainsSubview:(UIView *)subview;

@end
