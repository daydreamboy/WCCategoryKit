//
//  Test.m
//  Test
//
//  Created by wesley chen on 15/12/31.
//
//

#import <XCTest/XCTest.h>
#import "XCTestCase+Addition.h"

@interface Test : XCTestCase

@end

@implementation Test

- (void)setUp {
    [super setUp];
    NSLog(@"\n");
}

- (void)tearDown {
    NSLog(@"\n");
    [super tearDown];
}

/**
 *  Demonstrate the problem of test asynchronous network
 */
- (void)test_sendAsynchronousRequest {
    NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:30];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [self asyncBlockCompletedWithBlock:^{
            NSString *responseString = [[NSString alloc] initWithData:data
                                                             encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString); // Error: Will not output here
        }];
    }];
}

/**
 *  Example of runTestWithAsyncBlock: and asyncBlockCompletedWithBlock:
 */
- (void)test_runTestWithAsyncBlock_and_asyncBlockCompletedWithBlock {
    [self runTestWithAsyncBlock:^{
        NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL
                                                 cachePolicy:NSURLRequestReloadIgnoringCacheData
                                             timeoutInterval:30];

        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            [self asyncBlockCompletedWithBlock:^{
                NSString *responseString = [[NSString alloc] initWithData:data
                                                                 encoding:NSUTF8StringEncoding];
                NSLog(@"%@", responseString);
            }];
        }];
    }];
}

@end
