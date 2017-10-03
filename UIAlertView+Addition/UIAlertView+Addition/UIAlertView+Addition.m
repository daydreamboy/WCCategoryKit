//
//  UIAlertView+Addition.m
//  UIAlertView+Addition
//
//  Created by wesley chen on 15/6/25.
//
//

#import "UIAlertView+Addition.h"
#import <objc/runtime.h>

@implementation UIAlertView (Addition)

static const char * const UserInfoObjectTag = "UserInfoObjectTag";

@dynamic userInfo;

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, UserInfoObjectTag, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, UserInfoObjectTag);
}

@end
