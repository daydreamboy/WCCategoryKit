//
//  WCDeviceTool.m
//  AppTest
//
//  Created by wesley_chen on 22/03/2018.
//  Copyright © 2018 wesley_chen. All rights reserved.
//

#import "WCDeviceTool.h"

#import <sys/sysctl.h>
#import <mach/mach.h>

@implementation WCDeviceTool
@end

@implementation WCDeviceTool (Memory)

// 获取当前设备可用内存(单位：MB）
// @see https://gist.github.com/1901/917a0064b125175db95e
+ (double)systemAvailableMemory {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

/**
 获取当前任务所占用的内存（单位：MB）

 @return
 @see https://gist.github.com/1901/917a0064b125175db95e
 */
+ (double)processMemoryResident {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

+ (double)processMemoryFootprint {
    task_vm_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_VM_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_VM_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return taskInfo.phys_footprint / 1024.0 / 1024.0;
}
@end

