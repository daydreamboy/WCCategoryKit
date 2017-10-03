//
//  AppDelegate.m
//  AppTest
//
//  Created by wesley chen on 15/10/22.
//
//

#import "AppDelegate.h"
#import "NSFileManager+Addition.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"Home: %@", NSHomeDirectory());
    
    NSString *currentPath = [[NSFileManager defaultManager] currentDirectoryPath];
    NSLog(@"%@", currentPath);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directoryPath = ([paths count] > 0) ? paths[0] : nil;
    
    NSString *filePath1 = [NSString stringWithFormat:@"%@/%@", directoryPath, @"file3"];
//    NSString *filePath2 = [NSString stringWithFormat:@"%@/%@", directoryPath, @"file2"];
    
    NSString *fileContent1 = @"fileContent1";
    NSString *fileContent2 = @"fileContent2";
    
    [fileContent1 writeToFile:filePath1 atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    [fileContent2 writeToFile:filePath2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
    
    fileNames = [fileNames sortedArrayUsingComparator:^NSComparisonResult(NSString *fileName1, NSString *fileName2) {
        NSString *filePath1 = [NSString stringWithFormat:@"%@/%@", directoryPath, fileName1];
        NSString *filePath2 = [NSString stringWithFormat:@"%@/%@", directoryPath, fileName2];
        
        NSDictionary *attributes1 = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath1 error:nil];
        NSDictionary *attributes2 = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath2 error:nil];
        
        return attributes1[NSFileCreationDate] < attributes2[NSFileCreationDate];
    }];
    
    NSLog(@"fileNames: %@", fileNames);
    
    NSString *filePath3 = [NSString stringWithFormat:@"%@/test/test.txt", directoryPath];
    BOOL succeeded = [NSFileManager createNewFileAtPath:filePath3];
    if (succeeded) {
        NSLog(@"Ok");
    }
    
    NSString *filePath4 = [NSString stringWithFormat:@"%@/test2/tt.txt", directoryPath];
    succeeded = [[NSFileManager defaultManager] createFileAtPath:filePath4 contents:nil attributes:nil];
    NSLog(@"%@", succeeded ? @"OKK" : @"Failed");
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
