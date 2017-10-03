//
//  UILabel+Addition.m
//  UILabel+Addition
//
//  Created by wesley chen on 15/11/17.
//
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

/**
 *  measure text size for the label
 *
 *  @return {width, height} of the label's text
 *  @warning <br/> 1. the text is empty, width is zero, but height is not determined (iOS 7+ has value, but iOS 6- is 0)
 *           <br/> 2. the text is nil, width and height are 0.
 */
- (CGSize)measuredTextSizeForSingleLine {
    
    NSString *text = self.text;
    UIFont *font = self.font;
    
    CGSize textSize;
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
#ifdef __IPHONE_7_0
        textSize = [text sizeWithAttributes:@{ NSFontAttributeName : font }];
#endif
    }
    else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        textSize = [text sizeWithFont:font];
#pragma GCC diagnostic pop
    }
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

@end
