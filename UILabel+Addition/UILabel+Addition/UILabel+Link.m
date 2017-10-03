//
//  UILabel+Link.m
//  UILabel+Addition
//
//  Created by wesley chen on 16/4/13.
//
//

#import "UILabel+Link.h"
#import <objc/runtime.h>

@implementation UILabel (Link)

#pragma mark > clickableTextRanges

@dynamic clickableTextRanges;

static const NSString *sClickableTextRangesObjectTag = @"sClickableTextRangesObjectTag";

- (void)setClickableTextRanges:(NSArray<NSValue *> *)clickableTextRanges {
    objc_setAssociatedObject(self, &sClickableTextRangesObjectTag, clickableTextRanges, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<NSValue *> *)clickableTextRanges {
    return objc_getAssociatedObject(self, &sClickableTextRangesObjectTag);
}

#pragma mark

/*!
 *  Check if hit the clickableTextRange
 *
 *  @param tapRecognizer the UITapGestureRecognizer instance which is attatched to the UILabel
 *
 *  @return If YES, hit the clickableTextRange. If NO, not hit the clickableTextRange
 *  @sa http://stackoverflow.com/questions/1256887/create-tap-able-links-in-the-nsattributedtext-of-a-uilabel
 */
- (BOOL)isTappedOnClickableTextWithTapGesture:(UITapGestureRecognizer *)tapRecognizer atRange:(NSRange *)range {
    
    CGSize labelSize = self.bounds.size;
    // create instances of NSLayoutManager, NSTextContainer and NSTextStorage
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    
    // configure layoutManager and textStorage
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    // configure textContainer for the label
    textContainer.lineFragmentPadding = 0.0;
    textContainer.lineBreakMode = self.lineBreakMode;
    textContainer.maximumNumberOfLines = self.numberOfLines;
    textContainer.size = labelSize;
    
    // find the tapped character location and compare it to the specified range
    CGPoint locationOfTouchInLabel = [tapRecognizer locationInView:tapRecognizer.view];
    CGRect textBoundingBox = [layoutManager usedRectForTextContainer:textContainer];
    CGPoint textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                              (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                         locationOfTouchInLabel.y - textContainerOffset.y);
    // index started by 1
    NSInteger indexOfCharacter = [layoutManager characterIndexForPoint:locationOfTouchInTextContainer
                                                       inTextContainer:textContainer
                              fractionOfDistanceBetweenInsertionPoints:nil];
    
    BOOL isHitClickableText = NO;
    // If not out of whole text range(0, self.attributedText.length - 1)
    if (0 < indexOfCharacter && indexOfCharacter < self.attributedText.length - 1) {
        for (NSValue *value in self.clickableTextRanges) {
            NSRange r = [value rangeValue];
            
            BOOL found = NSLocationInRange(indexOfCharacter, r);
            if (found) {
                isHitClickableText = YES;
                if (range) {
                    *range = r;
                }
                break;
            }
        }
    }
    
    return isHitClickableText;
}

@end
