//
//  UITextField+Addition.m
//  Finance360
//
//  Created by wesley chen on 15/8/21.
//  Copyright (c) 2015年 qihoo. All rights reserved.
//

#import "UITextField+Addition.h"

@implementation UITextField (Addition)

#pragma mark - Conversion NSRange/UITextRange

/*!
 *  UITextRange to NSRange
 *
 *  @sa http://stackoverflow.com/questions/9126709/create-uitextrange-from-nsrange
 */
- (NSRange)rangeFromTextRange:(UITextRange *)textRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = self.selectedTextRange.start;
    UITextPosition *end = self.selectedTextRange.end;
    
    NSInteger location = [self offsetFromPosition:beginning toPosition:start];
    NSInteger length = [self offsetFromPosition:start toPosition:end];
    
    NSRange range = NSMakeRange(location, length);
    
    return range;
}

/*!
 *  NSRange to UITextRange
 */
- (UITextRange *)textRangeFromRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    
    UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];
    
    return textRange;
}

#pragma mark - Change Text Programatically

/*!
 *  Set UITextField's text by programmatically and leave cursor stay in place
 *
 *  @param range  the range to be replaced
 *  @param string the string to place
 *
 *  @return always NO, textField.text is changed, should NOT change it again
 *
 *  @sa http://stackoverflow.com/questions/11157791/how-to-move-cursor-in-uitextfield-after-setting-its-value
 *  @sa http://stackoverflow.com/questions/7305538/uitextfield-with-secure-entry-always-getting-cleared-before-editing
 *
 *  @warning should be called in textField:shouldChangeCharactersInRange:replacementString: delegate method
 */
- (BOOL)changeTextWithCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    
    // this will be the new cursor location after insert/paste/typing
    NSInteger cursorOffset = [self offsetFromPosition:beginning toPosition:start] + string.length;
    
    // now apply the text changes that were typed or pasted in to the text field
    self.text = [self.text stringByReplacingCharactersInRange:range withString:string];
    
    UITextPosition *newCursorPosition = [self positionFromPosition:self.beginningOfDocument offset:cursorOffset];
    UITextRange *newSelectedRange = [self textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
    [self setSelectedTextRange:newSelectedRange];
    
    return NO;
}

#pragma mark - Get selected range

// http://stackoverflow.com/questions/21149767/convert-selectedtextrange-uitextrange-to-nsrange
- (NSRange)selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    
    if (beginning && selectedRange) {
        UITextPosition *selectionStart = selectedRange.start;
        UITextPosition *selectionEnd = selectedRange.end;
        
        const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
        const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
        
        return NSMakeRange(location, length);
    }
    else {
        return NSMakeRange(NSNotFound, 0);
    }
}

@end
