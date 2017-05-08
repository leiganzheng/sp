//
//  DTNetManger.m
//  DouTu
//
//  Created by yuepengfei on 17/3/14.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTNetManger.h"

@implementation DTNetManger

+ (void)requestFailedCallBack:(callBack)callBack
{
    if (callBack) {
        NSError *error = [[self class] errorWithCode:0 description:nil];
        callBack(error,nil);
    }
}
+ (NSError *)errorWithCode:(int)code description:(NSString *)description
{
    NSString *msg = description ? description : @"";
    NSDictionary *infoDic = [NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"BizYixinErrorDomain" code:code userInfo:infoDic];
    return error;
}
+ (void)getSearchLisWithKeyWord:(NSString *)keyW PageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize callBack:(callBack)callBack{
    
}
+(void)loginWith:(NSString *)iphone PW:(NSString*)passWord callBack:(callBack)callBack{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         iphone,@"phone",
                         passWord,@"password",
                         nil];
    [HYBNetworking postWithUrl:kDTLoginUrl refreshCache:NO params:dic success:^(id response) {
       NSString *code = [(NSDictionary*)response objectForKey:@"code"];
       if (code) {
           if (callBack) {
               callBack(nil,response);
           }
       }else{
           [DTNetManger requestFailedCallBack:callBack];
       }
    } fail:^(NSError *error) {
        [DTNetManger requestFailedCallBack:callBack];
    }];
}
@end
