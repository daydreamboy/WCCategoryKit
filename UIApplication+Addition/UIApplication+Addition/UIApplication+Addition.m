//
//  UIApplication+Addition.m
//  UIApplication+Addition
//
//  Created by wesley chen on 16/3/8.
//
//

#import "UIApplication+Addition.h"

@implementation UIApplication (Addition)

+ (NSDictionary *)plistInfo {
    static dispatch_once_t onceToken;
    static NSDictionary *info;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        info = dict ?: [NSBundle mainBundle].infoDictionary;
    });
    
    return info;
}

#pragma mark - App Info

/*!
 *  App Version (Major Version), viewed in Target's 'General' -> 'Version'
 *
 *  @sa http://stackoverflow.com/questions/458632/how-can-my-iphone-app-detect-its-own-version-number
 */
+ (NSString *)appVersion {
    NSString *version = [[self plistInfo] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

/*!
 *  App Build Number (Minor Version), viewed in Target's 'General' -> 'Build'
 *
 *  @sa http://stackoverflow.com/questions/458632/how-can-my-iphone-app-detect-its-own-version-number
 */
+ (NSString *)appBuildNumber {
    // (NSString*)kCFBundleVersionKey is same as \@"CFBundleVersion"
    NSString *buildNumber = [[self plistInfo] objectForKey:@"CFBundleVersion"];
    return buildNumber;
}

/*!
 *  App Product Name
 */
+ (NSString *)appDisplayName {
    NSString *displayName = [[self plistInfo] objectForKey:@"CFBundleDisplayName"];
    return displayName;
}

/*!
 *  App Binary Executable File Name
 */
+ (NSString *)appExecutableName {
    NSString *executableName = [[self plistInfo] objectForKey:@"CFBundleExecutable"];
    return executableName;
}

/*!
 *  App Bundle Name
 */
+ (NSString *)appBundleName {
    // (NSString *)kCFBundleNameKey is same as \@"CFBundleName"
    NSString *bundleName = [[self plistInfo] objectForKey:@"CFBundleName"];
    return bundleName;
}

/*!
 *  App Bundle Identifier
 */
+ (NSString *)appBundleID {
    NSString *bundleID = [[self plistInfo] objectForKey:@"CFBundleIdentifier"];
    return bundleID;
}

/*!
 *  App Minimum Supported OS Version
 */
+ (NSString *)appMinimumSupportedOSVersion {
    NSString *minimumOSVersion = [[self plistInfo] objectForKey:@"MinimumOSVersion"];
    return minimumOSVersion;
}

/*!
 *  info.plist URL
 */
+ (NSURL *)appInfoPlistURL {
    NSURL *infoPlistURL = [[self plistInfo] objectForKey:@"CFBundleInfoPlistURL"];
    return infoPlistURL;
}

#pragma mark - App Directories

/*!
 *  Get the path of Documents directory
 *
 *  @return \@"/.../<app_home>/Documents"
 */
+ (NSString *)appDocumentsDirectory {
    return [self appSearchPathDirectory:NSDocumentDirectory];
}

/*!
 *  Get the path of Library directory
 *
 *  @return \@"/.../<app_home>/Library"
 */
+ (NSString *)appLibraryDirectory {
    return [self appSearchPathDirectory:NSLibraryDirectory];
}

/*!
 *  Get the path of Caches directory
 *
 *  @return \@"/.../<app_home>/Library/Caches"
 */
+ (NSString *)appCachesDirectory {
    return [self appSearchPathDirectory:NSCachesDirectory];
}

/*!
 *  Get the path of directories (Documents | Library | Caches)
 *
 *  @param searchPathDirectory the enum value (NSDocumentDirectory | NSLibraryDirectory | NSCachesDirectory)
 *
 *  @return the path of directory
 */
+ (NSString *)appSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES);
    NSString *directoryPath = ([paths count] > 0) ? paths[0] : nil;
    return directoryPath;
}

/*!
 *  Get the path of 'app_home' directory
 *
 *  @return \@"/.../<app_home>"
 */
+ (NSString *)appHomeDirectory {
    return NSHomeDirectory();
}

/*!
 *  Get the path of tmp directory
 *
 *  @return \@"/.../tmp/"
 */
+ (NSString *)appTmpDirectory {
    return NSTemporaryDirectory();
}

#pragma mark - App Build Macros

+ (BOOL)macroDefined_DEBUG {
#ifdef DEBUG
    return YES;
#else
    return NO;
#endif
}

+ (BOOL)macroOn_DEBUG {
#if DEBUG
    return YES;
#else
    return NO;
#endif
}

+ (BOOL)macroDefined_NDEBUG {
#ifdef NDEBUG
    return YES;
#else
    return NO;
#endif
}

+ (BOOL)macroOn_NS_BLOCK_ASSERTIONS {
#if NS_BLOCK_ASSERTIONS
    return YES;
#else
    return NO;
#endif
}

#pragma mark - App Event

+ (BOOL)allowUserInteractionEvents:(BOOL)isAllow {
    if (isAllow) {
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            return YES;
        }
    }
    else {
        if (![[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            return YES;
        }
    }
    
    return NO;
}

@end
