//
//  AppDelegate.m
//  AppTest
//
//  Created by wesley chen on 16/4/15.
//
//

#import "AppDelegate.h"

#import "NSObject+VarDump.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

static NSMutableString *sStringM;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self test_wc_object_dump_OnMultiThread];

    return YES;
}

- (void)test_wc_object_dump_OnMultiThread {
    for (NSUInteger i = 0; i < 10; i++) {
        [NSThread detachNewThreadSelector:@selector(onNewThread:) toTarget:self withObject:@(i)];
    }
}

- (void)onNewThread:(id)object {
    NSArray *arr = @[
        object,
        @(1),
        @"string",
        @(3.14),
        @(NO),
        [NSNull null],
        @[
            @(1),
            @"string",
            @(3.14),
            @(NO),
            [NSNull null],
        ],
        @"",
    ];

//    NSLog(@"%@ %@", object, wc_object_dump(arr));
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@", object);
    });
}

@end
