//
//  UIDevice+Addition.h
//  AppTest
//
//  Created by wesley_chen on 07/02/2018.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Addition)

#pragma mark - Device Info

/**
 the name of system, such as `iOS`

 @return a NSSttring
 */
+ (NSString *)systemName;

/**
 the name in `About`

 @return the
 */
+ (NSString *)deviceName;
+ (NSString *)systemVersion;
+ (NSString *)deviceModel; // @"iPhone"
+ (NSString *)deviceLocalizedModel; // @"iPhone"
+ (NSString *)deviceDetailedInfo; // @"iPhone xxx"
+ (NSString *)deviceTypeFormatted:(BOOL)formatted;


@end
