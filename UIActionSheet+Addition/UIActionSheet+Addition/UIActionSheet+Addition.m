//
//  UIActionSheet+Addition.m
//  LotteryMate
//
//  Created by wesley chen on 15/7/9.
//  Copyright (c) 2015年 Qihoo. All rights reserved.
//

#import "UIActionSheet+Addition.h"
#import <objc/runtime.h>

@implementation UIActionSheet (Addition)

const static char * const UserInfoObjectTag = "UserInfoObjectTag";

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, UserInfoObjectTag, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, UserInfoObjectTag);
}

@end
