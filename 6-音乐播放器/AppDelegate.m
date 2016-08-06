//
//  AppDelegate.m
//  6-音乐播放器
//
//  Created by yanhai on 15/6/10.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "musicPlayViewController.h"
#import "Music.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ViewController *viewcontrol = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = viewcontrol;
    [self.window release];
    [viewcontrol release];

    self.recentArray = [[[NSMutableArray alloc]init]autorelease];
    self.defineArray = [[[NSMutableArray alloc]init]autorelease];
    self.musicArray = [[NSMutableArray alloc]init];
    
    //从plist文件中添加歌曲
    NSString *plistPath = @"/Users/wyh/Desktop/YH/6-音乐播放器/6-音乐播放器/Music List.plist";
    
    NSMutableArray *listArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    for(int i = 0;i < listArray.count;i ++)
    {
        Music *music = [[Music alloc]initWithname:[[listArray objectAtIndex:i] objectAtIndex:0] picture:[[listArray objectAtIndex:i] objectAtIndex:2] AUthor:[[listArray objectAtIndex:i] objectAtIndex:1]];
        [self.musicArray addObject:music];
    }
    

    
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
