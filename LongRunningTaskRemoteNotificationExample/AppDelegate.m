//
//  AppDelegate.m
//  LongRunningTaskRemoteNotificationExample
//
//  Streamlined from http://www.raywenderlich.com/32960/apple-push-notification-services-in-ios-6-tutorial-part-1
//
//  Created by Bob Dugan on 11/17/15.
//  Copyright © 2015 Bob Dugan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//
// Delegate for UIApplicationDelegate
//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
      NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Let the device know we want to receive push notifications
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    // If we were launched BECAUSE of push notifications log this
    if (launchOptions != nil)
    {
        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil)
        {
            NSLog(@"%s: Launched from push notification: %@", __PRETTY_FUNCTION__, dictionary);
        }
    }
    
    return YES;
}

//
// Delegate for UIApplicationDelegate
//
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"%s: Copy this token to your server's notification: %@", __PRETTY_FUNCTION__, deviceToken);
}

//
// Delegate for UIApplicationDelegate
//
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"%s: Failed to get token, error: %@", __PRETTY_FUNCTION__, error);
}

//
// Delegate for UIApplicationDelegate
//
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"%s: Received notification: %@", __PRETTY_FUNCTION__, userInfo);
    [BackgroundTimeRemainingUtility NSLog];
}

//
// Delegate for UIApplicationDelegate
// http://stackoverflow.com/questions/22085234/didreceiveremotenotification-fetchcompletionhandler-open-from-icon-vs-push-not
//
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [BackgroundTimeRemainingUtility NSLog];
    
    NSLog(@"%s: %@",__PRETTY_FUNCTION__,userInfo);
    
    // Update UI
    dispatch_block_t work_to_do = ^{
        ViewController* controller = (ViewController*)  self.window.rootViewController;
        controller.notification.text = [NSString stringWithFormat:@"%@",userInfo];
    };
    
    if ([NSThread isMainThread])
    {
        work_to_do();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), work_to_do);
    }
    
    // Finish with completionHandler
    completionHandler(UIBackgroundFetchResultNewData);
}

//
// Delegate for UIApplicationDelegate
//
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)()) completionHandler
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}


//
// Delegate for UIApplicationDelegate
//
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

//
// Delegate for UIApplicationDelegate
//
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

//
// Delegate for UIApplicationDelegate
//
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

//
// Delegate for UIApplicationDelegate
//
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

//
// Delegate for UIApplicationDelegate
//
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

//
// Delegate for UIApplicationDelegate
//
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
