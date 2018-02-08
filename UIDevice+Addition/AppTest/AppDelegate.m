//
//  AppDelegate.m
//  AppTest
//
//  Created by wesley chen on 16/4/13.
//
//

#import "AppDelegate.h"

#import "RootViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) RootViewController *rootViewController;
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.rootViewController = [RootViewController new];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
    
    NSLog(@"%@", [[UIDevice currentDevice] systemName]);
    NSLog(@"%@", [[UIDevice currentDevice] name]);
    NSLog(@"%@", [[UIDevice currentDevice] systemVersion]);
    NSLog(@"%@", [[UIDevice currentDevice] model]);
    NSLog(@"%@", [[UIDevice currentDevice] localizedModel]);
    NSLog(@"%d", [[UIDevice currentDevice] userInterfaceIdiom]);
    NSLog(@"%@", [[UIDevice currentDevice] identifierForVendor]);
    NSLog(@"%d", [[UIDevice currentDevice] orientation]);
    NSLog(@"%f", [[UIDevice currentDevice] batteryLevel]);
    NSLog(@"%@", [[UIDevice currentDevice] isBatteryMonitoringEnabled] ? @"YES" : @"NO");
    NSLog(@"%d", [[UIDevice currentDevice] batteryState]);
    NSLog(@"%@", [[UIDevice currentDevice] isProximityMonitoringEnabled] ? @"YES" : @"NO");
    NSLog(@"%@", [[UIDevice currentDevice] proximityState] ? @"YES" : @"NO");
    
    /*
     2018-02-07 23:59:01.760546+0800 AppTest[86355:1188309] iOS
     2018-02-07 23:59:01.763217+0800 AppTest[86355:1188309] ali-138870
     2018-02-07 23:59:01.763480+0800 AppTest[86355:1188309] 11.2
     2018-02-07 23:59:01.763611+0800 AppTest[86355:1188309] iPhone
     2018-02-07 23:59:01.763714+0800 AppTest[86355:1188309] iPhone
     2018-02-07 23:59:01.763846+0800 AppTest[86355:1188309] 0
     2018-02-07 23:59:01.781401+0800 AppTest[86355:1188309] 8DB34166-F9AF-48C7-B529-3420D399AF96
     2018-02-07 23:59:01.781532+0800 AppTest[86355:1188309] 0
     2018-02-07 23:59:01.781643+0800 AppTest[86355:1188309] -1.000000
     2018-02-07 23:59:01.781745+0800 AppTest[86355:1188309] NO
     2018-02-07 23:59:01.781868+0800 AppTest[86355:1188309] 0
     2018-02-07 23:59:01.781986+0800 AppTest[86355:1188309] NO
     2018-02-07 23:59:01.782083+0800 AppTest[86355:1188309] NO
     */
    
    /*
     2018-02-08 00:02:21.360401+0800 AppTest[3515:1979973] iOS
     2018-02-08 00:02:21.383857+0800 AppTest[3515:1979973] 晨凉的 iPhone
     2018-02-08 00:02:21.383992+0800 AppTest[3515:1979973] 10.3.2
     2018-02-08 00:02:21.384072+0800 AppTest[3515:1979973] iPhone
     2018-02-08 00:02:21.384158+0800 AppTest[3515:1979973] iPhone
     2018-02-08 00:02:21.384195+0800 AppTest[3515:1979973] 0
     2018-02-08 00:02:21.411578+0800 AppTest[3515:1979973] 3A7961F0-6DED-4986-87F4-44C5FE5F5257
     2018-02-08 00:02:21.411658+0800 AppTest[3515:1979973] 0
     2018-02-08 00:02:21.411699+0800 AppTest[3515:1979973] -1.000000
     2018-02-08 00:02:21.411743+0800 AppTest[3515:1979973] NO
     2018-02-08 00:02:21.411777+0800 AppTest[3515:1979973] 0
     2018-02-08 00:02:21.411809+0800 AppTest[3515:1979973] NO
     2018-02-08 00:02:21.411841+0800 AppTest[3515:1979973] NO
     */
    
    return YES;
}

@end
