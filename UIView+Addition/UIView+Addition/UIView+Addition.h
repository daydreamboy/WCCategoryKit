//
//  UIView+Addition.h
//  LotteryMate
//
//  Created by wesley chen on 15/6/8.
//  Copyright (c) 2015年 Qihoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

/**
 Attatch an associated user object to the view. Usually used for UIAlertView or UIActionSheet
 */
@property (nonatomic, strong) id associatedUserObject;

/**
 Set a pair of key-value in associatedUserInfo which is attached to the view.
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *associatedUserInfo;

@end
