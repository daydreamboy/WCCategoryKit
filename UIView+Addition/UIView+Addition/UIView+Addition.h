//
//  UIView+Addition.h
//  LotteryMate
//
//  Created by wesley chen on 15/6/8.
//  Copyright (c) 2015年 Qihoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/*!
 *  Addition parameter for passing data in UIAlertView | UIActionSheet's delegate methods
 */
@property (nonatomic, strong) id userInfo;

#pragma mark - Debug

//
+ (void)enableDebugFrame:(BOOL)enabled;
//+ (void)enableDebugFrame:(BOOL)enabled usingFilterClasses:(NSArray *)filterClasses;
//+ (void)enableDebugFrame:(BOOL)enabled usingWatchedClasses:(NSArray *)watchedClasses;

#pragma mark - Tagging Single View

@property (nonatomic, strong) UIView *taggedView;

#pragma mark - Tagging Multiple Views

/// multiple tagged views
- (void)setTaggedView:(UIView *)taggedView forKey:(NSString *)key;
- (UIView *)taggedViewForKey:(NSString *)key;
- (void)removeAllTaggedViews;

@end
