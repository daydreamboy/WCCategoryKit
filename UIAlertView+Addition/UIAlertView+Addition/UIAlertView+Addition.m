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

- (NSMutableDictionary *)userInfo {
    NSMutableDictionary<NSString *, id> *userInfoM = objc_getAssociatedObject(self, UserInfoObjectTag);
    
    if (userInfoM == nil) {
        userInfoM = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UserInfoObjectTag, userInfoM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return userInfoM;
}

@end
