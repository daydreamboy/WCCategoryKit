//
//  UIWebView+Addition.m
//  UIWebView+Addition
//
//  Created by wesley chen on 15/4/12.
//
//

#import "UIWebView+Addition.h"

@implementation UIWebView (Addition)

/*!
 *  Get the whole html sorce code from webView
 */
- (NSString *)document {
    return [NSString stringWithFormat:@"%@\n%@", [self doctype], [self html]];
}

/*!
 *  Get the <html>...</html> part
 *
 *  @sa http://stackoverflow.com/questions/992348/reading-html-content-from-a-uiwebview
 */
- (NSString *)html {
    NSString *htmlString = [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
    return htmlString;
}

/*!
 *  Get the <!doctype ...> part
 *
 *  <!DOCTYPE html>
 *  <!DOCTYPE html SYSTEM "about:legacy-compat">
 *  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
 *
 *  @sa http://stackoverflow.com/questions/6088972/get-doctype-of-an-html-as-string-with-javascript
 *  @sa https://developer.mozilla.org/en-US/docs/Web/API/Document/doctype
 */
- (NSString *)doctype {
    NSString *name = [self stringByEvaluatingJavaScriptFromString:@"document.doctype.name"];
    NSString *publicId = [self stringByEvaluatingJavaScriptFromString:@"document.doctype.publicId"];
    NSString *systemId = [self stringByEvaluatingJavaScriptFromString:@"document.doctype.systemId"];
    
    NSMutableString *doctypeString = [NSMutableString stringWithString:@"<!DOCTYPE "];
    if (name.length) {
        [doctypeString appendString:name];
    }
    
    if (publicId.length) {
        [doctypeString appendFormat:@" PUBLIC \"%@\"", publicId];
    }
    
    if (!publicId.length && systemId.length) {
        [doctypeString appendString:@" SYSTEM"];
    }
    
    if (systemId.length) {
        [doctypeString appendFormat:@" \"%@\"", systemId];
    }
    
    [doctypeString appendString:@">"];
    
    return doctypeString;
}

@end
