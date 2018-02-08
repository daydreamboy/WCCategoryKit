//
//  UIDevice+Addition.m
//  AppTest
//
//  Created by wesley_chen on 07/02/2018.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import "UIDevice+Addition.h"
#import <sys/utsname.h>

@implementation UIDevice (Addition)

#pragma mark - Device Info

+ (NSString *)systemName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceModel {
    // @"iPhone", @"iPad"
    return [[UIDevice currentDevice] model];
}

+ (NSString *)deviceLocalizedModel {
    // @"iPhone"
    return [[UIDevice currentDevice] localizedModel];
}

+ (NSString *)deviceDetailedInfo {
    // e.g. @"iPhone xxx"
    return [NSString stringWithFormat:@"%@, %@ %@", [UIDevice deviceTypeFormatted:YES], [self systemName], [self systemVersion]];
}

// @see https://github.com/Shmoopi/iOS-System-Services/blob/master/System%20Services/Utilities/SSHardwareInfo.m
+ (NSString *)deviceTypeFormatted:(BOOL)formatted {
    NSString *deviceType;
    
    if (formatted) {
        @try {
            // Set up a struct
            struct utsname dt;
            // Get the system information
            uname(&dt);
            // Set the device type to the machine type
            deviceType = [NSString stringWithFormat:@"%s", dt.machine];
            
            // Note: set up a new Device Type String. By default, it's unknown
            NSString *newDeviceType = [NSString stringWithFormat:@"%@ Unknown (%@)", [[UIDevice currentDevice] model], deviceType];
            
            // Simulators
            if ([deviceType isEqualToString:@"i386"])
                newDeviceType = [NSString stringWithFormat:@"%@ Simulator", [[UIDevice currentDevice] model]];
            else if ([deviceType isEqualToString:@"x86_64"])
                newDeviceType = [NSString stringWithFormat:@"%@ Simulator", [[UIDevice currentDevice] model]];
            // iPhones
            else if ([deviceType isEqualToString:@"iPhone1,1"])
                newDeviceType = @"iPhone";
            else if ([deviceType isEqualToString:@"iPhone1,2"])
                newDeviceType = @"iPhone 3G";
            else if ([deviceType isEqualToString:@"iPhone2,1"])
                newDeviceType = @"iPhone 3GS";
            else if ([deviceType isEqualToString:@"iPhone3,1"])
                newDeviceType = @"iPhone 4";
            else if ([deviceType isEqualToString:@"iPhone4,1"])
                newDeviceType = @"iPhone 4S";
            else if ([deviceType isEqualToString:@"iPhone5,1"])
                newDeviceType = @"iPhone 5 (GSM)";
            else if ([deviceType isEqualToString:@"iPhone5,2"])
                newDeviceType = @"iPhone 5 (GSM+CDMA)";
            else if ([deviceType isEqualToString:@"iPhone5,3"])
                newDeviceType = @"iPhone 5c (GSM)";
            else if ([deviceType isEqualToString:@"iPhone5,4"])
                newDeviceType = @"iPhone 5c (GSM+CDMA)";
            else if ([deviceType isEqualToString:@"iPhone6,1"])
                newDeviceType = @"iPhone 5s (GSM)";
            else if ([deviceType isEqualToString:@"iPhone6,2"])
                newDeviceType = @"iPhone 5s (GSM+CDMA)";
            else if ([deviceType isEqualToString:@"iPhone7,1"])
                newDeviceType = @"iPhone 6 Plus";
            else if ([deviceType isEqualToString:@"iPhone7,2"])
                newDeviceType = @"iPhone 6";
            else if ([deviceType isEqualToString:@"iPhone8,1"])
                newDeviceType = @"iPhone 6s";
            else if ([deviceType isEqualToString:@"iPhone8,2"])
                newDeviceType = @"iPhone 6s Plus";
            else if ([deviceType isEqualToString:@"iPhone8,4"])
                newDeviceType = @"iPhone SE";
            else if ([deviceType isEqualToString:@"iPhone9,1"])
                newDeviceType = @"iPhone 7 (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone9,3"])
                newDeviceType = @"iPhone 7 (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone9,2"])
                newDeviceType = @"iPhone 7 Plus (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone9,4"])
                newDeviceType = @"iPhone 7 Plus (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,1"])
                newDeviceType = @"iPhone 8 (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,4"])
                newDeviceType = @"iPhone 8 (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,2"])
                newDeviceType = @"iPhone 8 Plus (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,5"])
                newDeviceType = @"iPhone 8 Plus (GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,3"])
                newDeviceType = @"iPhone X (CDMA+GSM/LTE)";
            else if ([deviceType isEqualToString:@"iPhone10,6"])
                newDeviceType = @"iPhone X (GSM/LTE)";
            // iPods
            else if ([deviceType isEqualToString:@"iPod1,1"])
                newDeviceType = @"iPod Touch 1G";
            else if ([deviceType isEqualToString:@"iPod2,1"])
                newDeviceType = @"iPod Touch 2G";
            else if ([deviceType isEqualToString:@"iPod3,1"])
                newDeviceType = @"iPod Touch 3G";
            else if ([deviceType isEqualToString:@"iPod4,1"])
                newDeviceType = @"iPod Touch 4G";
            else if ([deviceType isEqualToString:@"iPod5,1"])
                newDeviceType = @"iPod Touch 5G";
            else if ([deviceType isEqualToString:@"iPod7,1"])
                newDeviceType = @"iPod Touch 6G";
            // iPads
            else if ([deviceType isEqualToString:@"iPad1,1"])
                newDeviceType = @"iPad";
            else if ([deviceType isEqualToString:@"iPad2,1"])
                newDeviceType = @"iPad 2 (WiFi)";
            else if ([deviceType isEqualToString:@"iPad2,2"])
                newDeviceType = @"iPad 2 (GSM)";
            else if ([deviceType isEqualToString:@"iPad2,3"])
                newDeviceType = @"iPad 2 (CDMA)";
            else if ([deviceType isEqualToString:@"iPad2,4"])
                newDeviceType = @"iPad 2 (WiFi + New Chip)";
            else if ([deviceType isEqualToString:@"iPad2,5"])
                newDeviceType = @"iPad mini (WiFi)";
            else if ([deviceType isEqualToString:@"iPad2,6"])
                newDeviceType = @"iPad mini (GSM)";
            else if ([deviceType isEqualToString:@"iPad2,7"])
                newDeviceType = @"iPad mini (GSM+CDMA)";
            else if ([deviceType isEqualToString:@"iPad3,1"])
                newDeviceType = @"iPad 3 (WiFi)";
            else if ([deviceType isEqualToString:@"iPad3,2"])
                newDeviceType = @"iPad 3 (GSM)";
            else if ([deviceType isEqualToString:@"iPad3,3"])
                newDeviceType = @"iPad 3 (GSM+CDMA)";
            else if ([deviceType isEqualToString:@"iPad3,4"])
                newDeviceType = @"iPad 4 (WiFi)";
            else if ([deviceType isEqualToString:@"iPad3,5"])
                newDeviceType = @"iPad 4 (GSM)";
            else if ([deviceType isEqualToString:@"iPad3,6"])
                newDeviceType = @"iPad 4 (GSM+CDMA)";
            else if ([deviceType isEqualToString:@"iPad4,1"])
                newDeviceType = @"iPad Air (WiFi)";
            else if ([deviceType isEqualToString:@"iPad4,2"])
                newDeviceType = @"iPad Air (Cellular)";
            else if ([deviceType isEqualToString:@"iPad4,3"])
                newDeviceType = @"iPad Air (China)";
            else if ([deviceType isEqualToString:@"iPad4,4"])
                newDeviceType = @"iPad mini 2 (WiFi)";
            else if ([deviceType isEqualToString:@"iPad4,5"])
                newDeviceType = @"iPad mini 2 (Cellular)";
            else if ([deviceType isEqualToString:@"iPad5,1"])
                newDeviceType = @"iPad mini 4 (WiFi)";
            else if ([deviceType isEqualToString:@"iPad5,2"])
                newDeviceType = @"iPad mini 4 (Cellular)";
            else if ([deviceType isEqualToString:@"iPad5,4"])
                newDeviceType = @"iPad Air 2 (WiFi)";
            else if ([deviceType isEqualToString:@"iPad5,5"])
                newDeviceType = @"iPad Air 2 (Cellular)";
            else if ([deviceType isEqualToString:@"iPad6,3"])
                newDeviceType = @"9.7-inch iPad Pro (WiFi)";
            else if ([deviceType isEqualToString:@"iPad6,4"])
                newDeviceType = @"9.7-inch iPad Pro (Cellular)";
            else if ([deviceType isEqualToString:@"iPad6,7"])
                newDeviceType = @"12.9-inch iPad Pro (WiFi)";
            else if ([deviceType isEqualToString:@"iPad6,8"])
                newDeviceType = @"12.9-inch iPad Pro (Cellular)";
            else if ([deviceType isEqualToString:@"iPad6,11"])
                newDeviceType = @"iPad 5 (WiFi)";
            else if ([deviceType isEqualToString:@"iPad6,12"])
                newDeviceType = @"iPad 5 (Cellular)";
            else if ([deviceType isEqualToString:@"iPad7,1"])
                newDeviceType = @"iPad Pro 12.9 (2nd Gen - WiFi)";
            else if ([deviceType isEqualToString:@"iPad7,2"])
                newDeviceType = @"iPad Pro 12.9 (2nd Gen - Cellular)";
            else if ([deviceType isEqualToString:@"iPad7,3"])
                newDeviceType = @"iPad Pro 10.5 (WiFi)";
            else if ([deviceType isEqualToString:@"iPad7,4"])
                newDeviceType = @"iPad Pro 10.5 (Cellular)";
            // Catch All iPad
            else if ([deviceType hasPrefix:@"iPad"])
                newDeviceType = @"iPad";
            // Apple TV
            else if ([deviceType isEqualToString:@"AppleTV2,1"])
                newDeviceType = @"Apple TV 2";
            else if ([deviceType isEqualToString:@"AppleTV3,1"])
                newDeviceType = @"Apple TV 3";
            else if ([deviceType isEqualToString:@"AppleTV3,2"])
                newDeviceType = @"Apple TV 3 (2013)";
            
            // Return the new device type
            return newDeviceType;
        }
        @catch (NSException *exception) {
            // Error
            return nil;
        }
    }
    else {
        // Unformatted
        @try {
            // Set up a struct
            struct utsname dt;
            // Get the system information
            uname(&dt);
            // Set the device type to the machine type
            deviceType = [NSString stringWithFormat:@"%s", dt.machine];
            
            // Return the device type
            return deviceType;
        }
        @catch (NSException *exception) {
            // Error
            return nil;
        }
    }
}

@end
