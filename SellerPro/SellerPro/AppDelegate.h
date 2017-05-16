//
//  AppDelegate.h
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)NSString* token;
@property (strong, nonatomic)NSString* rtoken;
@property (strong, nonatomic)NSString* phone;
- (void)openCountdown:(NSInteger)sum;
@end

