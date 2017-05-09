//
//  Tools.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/8.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "Tools.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>


@implementation Tools

+(void)configCornerOfView:(UIView *)view with:(NSInteger)value{
    if (view) {
        view.layer.cornerRadius = 3;
        view.layer.masksToBounds = YES;
    }
}
+(void)enterRootViewController:(UIViewController *)vc animated:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIView *animationView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
    if (appDelegate) {
        [appDelegate.window addSubview:animationView];
        UIViewController *control = appDelegate.window.rootViewController;
        UIViewController *viewController = control.presentingViewController;
        if (viewController) {
            [viewController dismissViewControllerAnimated:NO completion:^{
                [self changeRootViewController:vc animationView:animationView animated:YES];
            }];
        }else{
            [self changeRootViewController:vc animationView:animationView animated:YES];
        }
    }
}
+(void)changeRootViewController:(UIViewController *)vc animationView:(UIView*)animationView animated:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = vc;
    if (animated) {
        [appDelegate.window bringSubviewToFront:animationView];
        [UIView animateWithDuration:0.5 animations:^{
            animationView.transform = CGAffineTransformMakeScale(3.0, 3.0);
            animationView.alpha = 0;
        } completion:^(BOOL finished) {
            [animationView removeFromSuperview];
        }];
    }else{
        [animationView removeFromSuperview];
    }
}
+ (void)configOrignNetWork{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"ios",@"client-type",
                         OpenUDID.value,@"client-imei",
                         @"1.0",@"client-version",
                         [self timeStamp:YES], @"timestamp",
                         [self signature],@"signature",
                         ((AppDelegate*)[UIApplication sharedApplication].delegate).token, @"token",
                         ((AppDelegate*)[UIApplication sharedApplication].delegate).rtoken,@"refresh-token",
                         nil];
    [HYBNetworking configCommonHttpHeaders:dic];

}
+(NSString*)timeStamp:(BOOL)flag{
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
    //    NSString *confromTimespStr = [dateformatter stringFromDate:confromTimesp];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[confromTimesp timeIntervalSince1970]];  //    NSLog(@"时间戳转时间   = %@",confromTimespStr);
    if (flag) {
        if (timeSp.length >10) {
            return [timeSp substringToIndex:10];
        }
        return timeSp;
    }else{
        return timeSp;
    }
}
+(NSString*)signature{
    //    merchant_ios
    NSString * str = [NSString stringWithFormat:@"%@%@", @"merchant_ios", [self timeStamp:NO]];
    //sha1
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    //    if (output.length >40) {
    //        return [output substringToIndex:40];
    //    }
    return output;
}
@end
