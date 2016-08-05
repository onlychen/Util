//
//  AppDelegate.m
//  Util
//
//  Created by chenliang on 16/7/19.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+HexValue.h"
#import "CYLTabBarControllerConfig.h"
#import "LBLaunchImageAdView.h"
#import <iflyMSC/IFlySpeechUtility.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    [IFlySpeechUtility createUtility:initString];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    [self loadRootVc];
//    LBLaunchImageAdView * adView = [[LBLaunchImageAdView alloc]initWithWindow:self.window andType:FullScreenAdType andImgUrl:@"http://www.uisheji.com/wp-content/uploads/2013/04/19/app-design-uisheji-ui-icon20121_55.jpg"];
//    adView.clickBlock = ^(NSInteger tag){
//        switch (tag) {
//            case 1100:
//            {
//                NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/it-blog-for-ios-developers/id1067787090?mt=8"];
//                [[UIApplication sharedApplication] openURL:url];
//            }
//            break;
//            case 1101:
//            {
//                break;
//            }
//            case 1102:
//            {
//                break;
//            }
//            default:
//                break;
//        }
//        
//    };

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexValue:@"ed562e"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    return YES;
}

#pragma mark -根视图设置
-(void)loadRootVc
{
    CYLTabBarControllerConfig* tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    [self.window setRootViewController:tabBarControllerConfig.tabBarController];
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
