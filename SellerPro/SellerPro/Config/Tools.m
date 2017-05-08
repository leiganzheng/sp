//
//  Tools.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/8.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(void)configCornerOfView:(UIView *)view with:(NSInteger)value{
    if (view) {
        view.layer.cornerRadius = 3;
        view.layer.masksToBounds = YES;
    }
}
@end
