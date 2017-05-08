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
//登录
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
//获取验证码
+(void)verifyCodeWith:(NSString *)phone callBack:(callBack)callBack{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         phone,@"phone",
                         nil];
    [HYBNetworking postWithUrl:kDVerifyCodeUrl refreshCache:NO params:dic success:^(id response) {
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
//校验验证码
+(void)checkVerifyCodeWith:(NSString *)phone code:(NSString *)verifyCode callBack:(callBack)callBack{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         phone,@"phone",
                         verifyCode,@"verify_code",
                         nil];
    [HYBNetworking postWithUrl:kDTCheckVerifyCodeUrl refreshCache:NO params:dic success:^(id response) {
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
////修改密码
+(void)modifyPassWordWith:(NSString *)phone PW:(NSString *)passWord code:(NSString *)verifyCode callBack:(callBack)callBack{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         phone,@"phone",
                         passWord,@"password",
                         verifyCode,@"verify_code",
                         nil];
    [HYBNetworking postWithUrl:kDTMpasswordUrl refreshCache:NO params:dic success:^(id response) {
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
//获取服务单分页
+(void)orderPageWith:(NSInteger)page size:(NSInteger)size date:(NSString *)date callBack:(callBack)callBack{
    
}
//获取员工业绩分页
+(void)orderStaffPageWith:(NSInteger)page size:(NSInteger)size date:(NSString *)date callBack:(callBack)callBack{
    
}
//获取服务项目业绩分页
+(void)orderServicePageWith:(NSInteger)page
                       size:(NSInteger)size
                       date:(NSString*)date
                   callBack:(callBack)callBack{
    
}
//获取工种列表
+(void)workStypeListWithCallBack:(callBack)callBack{
    
}
//获取工种注册地址
+(void)getUrlOfWorkTypeWith:(NSInteger)typeId
                   callBack:(callBack)callBack{
    
}
//获取工种资料
+(void)getUrlOfWorkInfoWith:(NSInteger)typeId
                   callBack:(callBack)callBack{
    
}
//添加/修改工种
+(void)addWorkTypeWith:(NSInteger)typeId
                  name:(NSString*)name
              callBack:(callBack)callBack{
    
}
//删除工种
+(void)delWorkTypeWith:(NSInteger)typeId
              callBack:(callBack)callBack{
    
}
//获取服务分类列表
+(void)seviceListWithCallBack:(callBack)callBack{
    
}
//获取服务项目资料
+(void)getServiceInfoWith:(NSInteger)typeId
                 callBack:(callBack)callBack{
    
}
//添加/修改服务项目
+(void)addServiceWith:(NSInteger)service_id
           categoryId:(NSInteger)categoryId
                 name:(NSString*)name
                price:(float)price
             callBack:(callBack)callBack{
    
}
//删除服务项目
+(void)delServiceTypeWith:(NSInteger)serviceId
                 callBack:(callBack)callBack{
    
}
//获取员工分页
+(void)StaffPageWith:(NSInteger)page
                size:(NSInteger)size
            callBack:(callBack)callBack{
    
}
//获取员工资料
+(void)getStaffInfoWith:(NSInteger)staffId
               callBack:(callBack)callBack{
    
}
//修改员工
+(void)addStaffWith:(NSInteger)staff_id
       work_type_id:(NSInteger)work_type_id
               name:(NSString*)name
        is_disabled:(NSInteger)is_disabled //状态(0->在职，1->离职)
           callBack:(callBack)callBack{
    
}
//删除员工
+(void)delStaffInfoWith:(NSInteger)staffId
               callBack:(callBack)callBack{
    
}
@end
