//
//  Tools.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/8.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "Tools.h"
#import "AppDelegate.h"
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
@end
