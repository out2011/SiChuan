//
//  AppDelegate.m
//  sichuan
//
//  Created by Lu.L on 16/1/21.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "AppDelegate.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
#import "GeTuiSdk.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"

//#define kGtAppId           @"LQuJmpN9dO8oJPGl8PEPr3"
//#define kGtAppKey          @"aVlcTi1cagAWwXsgkblhM1"
//#define kGtAppSecret       @"Kaz5Z7nfPx7A8Saogn6KC"
// 个推
#define kGtAppId     @"qDPpO4r3M98kWZXSpbOPA3"
#define kGtAppKey    @"TgzLhn6f3a5bZCOZdKpAD9"
#define kGtAppSecret @"ZtygHSElCqAxOmJVzoRwG"
// 百度地图
#define kBDMapKey    @"VTc505oSe4g68Onk2eLsMKq8"
// share SDK
#define kShareKey    @"fdb0a4a2e140"
// 微博
#define kWBAppKey    @"3859129567"
#define kWBAppSecret @"4eb21b8a532adfda253766778a6eeb32"
// 微信
#define kWXAppSecret @"2344425428daaf8cda1ad6557fac1de9"
#define kWXAppID     @"wxf335847c0e8fecf9"
// 腾讯
#define kTXAppKey    @"AWRrZt3L4QEVFT6r"
#define kTXAppID     @"1105213352"

@interface AppDelegate ()<BMKGeneralDelegate, GeTuiSdkDelegate>

@end

BMKMapManager *_mapManager;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /// 百度地图
    _mapManager = [[BMKMapManager alloc] init];
    [_mapManager start:kBDMapKey generalDelegate:self];
    
    /// 个推
    // 通过 appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId
                         appKey:kGtAppKey
                      appSecret:kGtAppSecret
                       delegate:self];
    
    // 注册APNS
    [self registerUserNotification];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];
    
    [GeTuiSdk clearAllNotificationForNotificationBar];
    
    /// share SDK
    [ShareSDK registerApp:kShareKey
          activePlatforms:@[@(SSDKPlatformSubTypeQQFriend),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeSinaWeibo)
                            ] onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
                 
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                      // 微博分享
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:kWBAppKey
                                                appSecret:kWBAppSecret
                                              redirectUri:@"http://www.sc.gov.cn/"
                                                 authType:SSDKAuthTypeSSO];
                      break;
                      // 微信
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:kWXAppID
                                            appSecret:kWXAppSecret];
                      break;
                      // QQ好友
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:kTXAppID
                                           appKey:kTXAppKey
                                         authType:SSDKAuthTypeSSO];
                      break;
                  default:
                      break;
              }
          }];
    
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

#pragma mark - baidu map Memory management

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else {
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

#pragma mark - ge tui delegate

// 用户通知(推送) _自定义方法
/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    
    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else { // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // 注册远程通知 -根据远程通知类型
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
        return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
}

#pragma mark - 用户通知(推送)回调 _IOS 8.0以上使用

/** 已登记用户通知 */
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 注册远程通知（推送）
    [application registerForRemoteNotifications];
}

#pragma mark - 远程通知(推送)回调

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *myToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken = [myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [GeTuiSdk registerDeviceToken:myToken];
    
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", myToken);
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    [GeTuiSdk registerDeviceToken:@""];
    
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}

#pragma mark - APP运行中接收到通知(推送)处理
/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // 处理APN
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n", userInfo);
    
    /// 收到透传消息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushMessage" object:self userInfo:userInfo];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}


/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId {
    
    // [4]: 收到个推消息
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@" payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@", payloadId, taskId, aMsgId, payloadMsg, offLine ? @"<离线消息>" : @""];
    
    /// 收到透传消息
//    NSData *jsonData = [payloadMsg dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushMessage" object:self userInfo:dicData];
    //
        NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // [EXT]:通知SDK运行状态
    NSLog(@"\n>>>[GexinSdk SdkState]:%u\n\n", aStatus);
}

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        NSLog(@"\n>>>[GexinSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
        return;
    }
    
    NSLog(@"\n>>>[GexinSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
}


@end
