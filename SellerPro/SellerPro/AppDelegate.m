//
//  AppDelegate.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barStyle = UIBarStyleBlack;
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] , NSFontAttributeName:DT_Nav_TitleFont}];
    navBar.barTintColor = [UIColor blackColor];
    [self setUpBaseNetwork];
    return YES;
}
- (void)setUpBaseNetwork
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring]; //检测网络
    [HYBNetworking updateBaseUrl:kDTBaseHostUrl];                   //默认hostUrl
    [HYBNetworking configRequestType:kHYBRequestTypePlainText       //请求类型 数据类型 Encode Url
                        responseType:kHYBResponseTypeJSON
                 shouldAutoEncodeUrl:YES
             callbackOnCancelRequest:NO];
    [HYBNetworking enableInterfaceDebug:NO];                        //是否开启debug模式
    [HYBNetworking obtainDataFromLocalWhenNetworkUnconnected:YES];  //网络异常时本地获取数据
    [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];         //数据缓存
    [HYBNetworking setTimeout:20.f];                                //超时回调
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"client-type", @"ios",
                          @"client-imei", OpenUDID.value,
                          @"client-version", @"1.0",
                          @"timestamp", [self timeStamp],
                          @"signature", @"",
                          @"token",@"",
                          @"refresh-token",@"",
                          nil];
    [HYBNetworking configCommonHttpHeaders:dic];

}
-(NSString*)timeStamp{
    NSDate *senddate = [NSDate date];
    
    NSLog(@"date1时间戳 = %ld",time(NULL));
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    NSLog(@"date2时间戳 = %@",date2);
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *date1 = [dateformatter stringFromDate:senddate];
    NSLog(@"获取当前时间   = %@",date1);
    
    // 时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[senddate timeIntervalSince1970]];
    NSString *confromTimespStr = [dateformatter stringFromDate:confromTimesp];
    NSLog(@"时间戳转时间   = %@",confromTimespStr);
    return confromTimespStr;
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
