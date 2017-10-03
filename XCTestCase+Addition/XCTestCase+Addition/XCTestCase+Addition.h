//
//  XCTestCase+Addition.h
//  ApolloSDK
//
//  Created by wesley chen on 15/11/3.
//  Copyright © 2015年 DiDi Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (Addition)

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

- (void)runTestWithAsyncBlock:(void (^)(void))block;
- (void)asyncBlockCompletedWithBlock:(void (^)(void))block;

@end
