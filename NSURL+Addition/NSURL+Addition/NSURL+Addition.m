//
//  NSURL+Addition.m
//  NSURL+Addition
//
//  Created by wesley chen on 15/7/24.
//
//

#import "NSURL+Addition.h"

@implementation NSURL (Addition)

/*!
 *  Get the base part of NSURL without query parameters
 *
 *  @sa http://stackoverflow.com/questions/4271916/url-minus-query-string-in-objective-c
 *  @return e.g. `http://www.abc.com/foo/bar.cgi` instead of original http://www.abc.com/foo/bar.cgi?a=1&b=2
 */
- (NSURL *)mainURL {
    return [[NSURL alloc] initWithScheme:self.scheme host:self.host path:self.path];
}

@end
