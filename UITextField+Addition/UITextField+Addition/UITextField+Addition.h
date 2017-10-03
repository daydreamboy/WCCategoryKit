//
//  UITextField+Addition.h
//  Finance360
//
//  Created by wesley chen on 15/8/21.
//  Copyright (c) 2015年 qihoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Addition)

#pragma mark - Conversion NSRange/UITextRange

- (NSRange)rangeFromTextRange:(UITextRange *)textRange;
- (UITextRange *)textRangeFromRange:(NSRange)range;

#pragma mark - Change Text Programatically

- (BOOL)changeTextWithCharactersInRange:(NSRange)range replacementString:(NSString *)string;

#pragma mark - Get selected range

- (NSRange)selectedRange;

@end
