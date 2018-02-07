//
//  UIApplication+Addition.h
//  UIApplication+Addition
//
//  Created by wesley chen on 16/3/8.
//
//

#import <UIKit/UIKit.h>

@interface UIApplication (Addition)

#pragma mark - App Info

+ (NSString *)appVersion;
+ (NSString *)appBuildNumber;
+ (NSString *)appDisplayName;
+ (NSString *)appExecutableName;
+ (NSString *)appBundleName;
+ (NSString *)appBundleID;
+ (NSString *)appMinimumSupportedOSVersion;
+ (NSURL *)appInfoPlistURL;

#pragma mark - App Directories

+ (NSString *)appDocumentsDirectory;
+ (NSString *)appLibraryDirectory;
+ (NSString *)appCachesDirectory;
+ (NSString *)appSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory;
+ (NSString *)appHomeDirectory;
+ (NSString *)appTmpDirectory;

#pragma mark - App Build Macros

+ (BOOL)macroDefined_DEBUG;
+ (BOOL)macroDefined_NDEBUG;
+ (BOOL)macroOn_DEBUG;
+ (BOOL)macroOn_NS_BLOCK_ASSERTIONS;

#pragma mark - App Event

/*!
 *  enable/disable user interaction
 *
 *  @param isAllow YES, enable user interaction; NO, disable user interaction
 *
 *  @return If YES, operation is done. If NO, operation is ignored
 *  @warning
 *  <br/> 1. This method must be paired with YES and NO
 *  <br/> 2. This method doesn't work with third-party keyboard on iOS 8+, when disable user interaction but user still can press key
 */
+ (BOOL)allowUserInteractionEvents:(BOOL)isAllow;

@end
