//
//  AppDelegate.m
//  SocialShare
//
//  Created by Tsz on 15/11/14.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import  "UMSocialSinaHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 关于授权:
 如果要让分享内容的最下面, 显示是自己的App名称, 就必须注册各个开发者平台, 设置appkey等
 否则, 会一直显示是友盟分享的字样, 且点击链接时, 会跳转到友盟官网
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //添加APPKey
    [UMSocialData setAppKey:@"559bb90967e58e9f0a003d02"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    return YES;
}

#pragma mark: 添加回调方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [UMSocialSnsService handleOpenURL:url];
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
