//
//  AppDelegate+parsePushNotification.m
//  HelloWorld
//
//  Created by yoyo on 2/12/14.
//
//

#import "AppDelegate+parsePushNotification.h"

#import "ParsePushNotificationPlugin.h"
#import <objc/runtime.h>
#import <Parse/Parse.h>
#import "MainViewController.h"
#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate (parsePushNotification)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *parsePlist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ParsePush" ofType:@"plist"]];
    NSString *crashlyticsId = [parsePlist objectForKey:@"crashlyticsId"];
    [Crashlytics startWithAPIKey:crashlyticsId];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

#if __has_feature(objc_arc)
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
#else
    self.window = [[[UIWindow alloc] initWithFrame:screenBounds] autorelease];
#endif
    self.window.autoresizesSubviews = YES;
    
#if __has_feature(objc_arc)
    self.viewController = [[MainViewController alloc] init];
#else
    self.viewController = [[[MainViewController alloc] init] autorelease];
#endif
    
    // Set your app's start page by setting the <content src='foo.html' /> tag in config.xml.
    // If necessary, uncomment the line below to override it.
    // self.viewController.startPage = @"index.html";
    
    // NOTE: To customize the view's frame size (which defaults to full screen), override
    // [self.viewController viewWillAppear:] in your view controller.
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    ParsePushNotificationPlugin *pushHandler = [self getCommandInstance:@"ParsePushNotificationPlugin"];
    [pushHandler didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    ParsePushNotificationPlugin *pushHandler = [self getCommandInstance:@"ParsePushNotificationPlugin"];
    [pushHandler didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)payload
{
    
    NSLog(@"didReceiveRemoteNotification");
    UIApplicationState appstate = [[UIApplication sharedApplication] applicationState];
    
    
    NSMutableDictionary *extendedPayload = [payload mutableCopy];
    [extendedPayload setObject:[NSNumber numberWithBool:(appstate == UIApplicationStateActive)] forKey:@"receivedInForeground"];
    
    ParsePushNotificationPlugin *pushHandler = [self getCommandInstance:@"ParsePushNotificationPlugin"];
    [pushHandler didReceiveRemoteNotificationWithPayload:extendedPayload];
}

- (id) getCommandInstance:(NSString*)className
{
    return [self.viewController getCommandInstance:className];
}


@end
