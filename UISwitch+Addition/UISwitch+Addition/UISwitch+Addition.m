//
//  UISwitch+Addition.m
//  LotteryMate
//
//  Created by wesley chen on 15/7/9.
//  Copyright (c) 2015年 Qihoo. All rights reserved.
//

#import "UISwitch+Addition.h"
#import <objc/runtime.h>

@implementation UISwitch (Addition)

static const char * const UserInfoObjectTag = "UserInfoObjectTag";

@dynamic userInfo;

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, UserInfoObjectTag, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, UserInfoObjectTag);
}

@end
