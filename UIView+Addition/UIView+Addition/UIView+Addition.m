//
//  UIView+Addition.m
//  LotteryMate
//
//  Created by wesley chen on 15/6/8.
//  Copyright (c) 2015年 Qihoo. All rights reserved.
//

#import "UIView+Addition.h"
#import <objc/runtime.h>

@interface WCRuntimeTool : NSObject

+ (void)exchangeSelectorForClass:(Class)c origin:(SEL)orig substitute:(SEL)replace;

@end

@implementation UIView (Frame)

static const char * const UIView_Frame_UserInfoObjectTag = "UIView_Frame_UserInfoObjectTag";

@dynamic userInfo;

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, UIView_Frame_UserInfoObjectTag, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, UIView_Frame_UserInfoObjectTag);
}

static BOOL debugFrameEnabled;

#pragma mark - Debug

+ (void)enableDebugFrame:(BOOL)enabled {
    debugFrameEnabled = enabled;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class viewClass = NSClassFromString(@"UIView");
        [WCRuntimeTool exchangeSelectorForClass:viewClass origin:@selector(layoutSubviews) substitute:@selector(layoutSubviews_intercepted)];
        
        Class buttonClass = NSClassFromString(@"UIControl");
        [WCRuntimeTool exchangeSelectorForClass:buttonClass origin:@selector(layoutSubviews) substitute:@selector(testButton)];
    });
}

- (void)layoutSubviews_intercepted {
    [self layoutSubviews_intercepted];
    
    if (debugFrameEnabled) {
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 0.5f;
    }
    else {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.0f;
    }
}

- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
}

- (void)testButton {
    [self testButton];
}

#pragma mark - Tagging Single View

@dynamic taggedView;

static const NSString *sTaggedViewObjectTag = @"sTaggedViewObjectTag";

- (void)setTaggedView:(UIView *)taggedView {
    objc_setAssociatedObject(self, &sTaggedViewObjectTag, taggedView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)taggedView {
    return objc_getAssociatedObject(self, &sTaggedViewObjectTag);
}

#pragma mark - Tagging Multiple Views

static NSMutableDictionary *sTaggedViewContainer;

- (void)setTaggedView:(UIView *)taggedView forKey:(NSString *)key {
    if (!sTaggedViewContainer) {
        sTaggedViewContainer = [NSMutableDictionary dictionary];
    }
    
    if (key) {
        [sTaggedViewContainer setObject:taggedView forKey:key];
    } else {
        [sTaggedViewContainer removeObjectForKey:key];
    }
}

- (UIView *)taggedViewForKey:(NSString *)key {
    return [sTaggedViewContainer objectForKey:key];
}

- (void)removeAllTaggedViews {
    [sTaggedViewContainer removeAllObjects];
    sTaggedViewContainer = nil;
}

@end

@implementation WCRuntimeTool

/*!
 *  Exchange IMPs for two Methods
 *
 *  @param c       the Class to be modified
 *  @param orig    the origin Method
 *  @param replace the substitute Method
 */
+ (void)exchangeSelectorForClass:(Class)c origin:(SEL)origin substitute:(SEL)replace {
    Method origMethod = class_getInstanceMethod(c, origin);
    Method replaceMethod = class_getInstanceMethod(c, replace);
    
    if (class_addMethod(c, origin, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod))) {
        class_replaceMethod(c, replace, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else {
        method_exchangeImplementations(origMethod, replaceMethod);
    }
}

@end
