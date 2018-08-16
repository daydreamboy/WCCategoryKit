//
//  UIView+Addition.m
//  LotteryMate
//
//  Created by wesley chen on 15/6/8.
//  Copyright (c) 2015年 Qihoo. All rights reserved.
//

#import "UIView+Addition.h"
#import <objc/runtime.h>

@implementation UIView (Addition)

@dynamic associatedUserObject;
@dynamic associatedUserInfo;

- (void)setAssociatedUserObject:(id)userObject {
    objc_setAssociatedObject(self, @selector(associatedUserObject), userObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedUserObject {
    return objc_getAssociatedObject(self, @selector(associatedUserObject));
}

- (NSMutableDictionary *)associatedUserInfo {
    NSMutableDictionary *dictM = objc_getAssociatedObject(self, @selector(associatedUserInfo));
    
    if (dictM == nil) {
        @synchronized(self) {
            if (dictM == nil) {
                dictM = [NSMutableDictionary dictionary];
                objc_setAssociatedObject(dictM, @selector(associatedUserInfo), dictM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
    }
    
    return dictM;
}

@end

