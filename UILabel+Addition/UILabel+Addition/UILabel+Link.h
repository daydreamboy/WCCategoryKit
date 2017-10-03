//
//  UILabel+Link.h
//  UILabel+Addition
//
//  Created by wesley chen on 16/4/13.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (Link)

// Warning: not support for multiple lines
@property (nonatomic, strong) NSArray<NSValue *> *clickableTextRanges;

- (BOOL)isTappedOnClickableTextWithTapGesture:(UITapGestureRecognizer *)tapRecognizer atRange:(NSRange *)range NS_AVAILABLE_IOS(7_0);

@end
