//
//  UIAlertView+Addition.h
//  UIAlertView+Addition
//
//  Created by wesley chen on 15/6/25.
//
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Addition)

/*!
 *  Addition parameter for passing data in UIAlertView's delegate methods
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *userInfo;

@end
