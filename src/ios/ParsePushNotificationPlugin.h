//
//  ParsePushNotificationPlugin.h
//  HelloWorld
//
//  Created by yoyo on 2/12/14.
//
//

#import <Cordova/CDV.h>

@interface ParsePushNotificationPlugin : CDVPlugin
    {

    }
    
    @property (nonatomic, copy) NSString *callbackId;


    
- (void)register:(CDVInvokedUrlCommand*)command;
    
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;  
- (void)didReceiveRemoteNotificationWithPayload:(NSDictionary *)payload;
    
@end
