//
//  WCDeviceTool.h
//  AppTest
//
//  Created by wesley_chen on 22/03/2018.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCDeviceTool : NSObject
@end

@interface WCDeviceTool (Memory)
+ (double)systemAvailableMemory;
+ (double)processMemoryResident;

/**
 查看内存footprint（基本和Memory Report显示一致）

 @return the memory footprint
 
 @note https://forums.developer.apple.com/thread/52186
 */
+ (double)processMemoryFootprint;
@end
