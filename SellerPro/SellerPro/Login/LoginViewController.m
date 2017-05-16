//
//  LoginViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPWViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _phoneTF.text = @"18682242936";
    _pwTF.text = @"123";
    [Tools configCornerOfView:_login with:3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (IBAction)loginAction:(id)sender {
    if ([self check]) {
        [DTNetManger loginWith:_phoneTF.text PW:_pwTF.text callBack:^(NSError *error, id response) {
            if (response && [response isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)response;
                ((AppDelegate*)[UIApplication sharedApplication].delegate).token = dict[@"token"];
                ((AppDelegate*)[UIApplication sharedApplication].delegate).rtoken = dict[@"refresh_token"];
                ((AppDelegate*)[UIApplication sharedApplication].delegate).phone = _phoneTF.text;
                
                NSString *sum = [NSString stringWithFormat:@"%@",dict[@"token_expires"]];
//                [self interceptTimeStampFromStr:sum];
                [((AppDelegate*)[UIApplication sharedApplication].delegate) openCountdown:sum.integerValue];
                
                //跳转
                UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
                MainViewController *main = [board instantiateViewControllerWithIdentifier:@"MainViewController"];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main];
                [Tools enterRootViewController:nav animated:YES];
            }else{
                [MBProgressHUD showError:@"登录失败，请重试" toView:self.view];
            }
        }];
    }
}
- (NSString *)interceptTimeStampFromStr:(NSString *)str{
    if (!str || [str length] == 0 ) {  // 字符串为空判断
        return @"";
    }
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    NSString * timeStampString = [NSString string];
    //  遍历取出括号内的时间戳
    for (int i = 0; i < str.length; i ++) {
        NSRange startRang = [muStr rangeOfString:@"("];
        NSRange endRang = [muStr rangeOfString:@")"];
        if (startRang.location != NSNotFound) {
            // 左边括号位置
            NSInteger loc = startRang.location;
            // 右边括号距离左边括号的长度
            NSInteger len = endRang.location - startRang.location;
            // 截取括号时间戳内容
            timeStampString = [muStr substringWithRange:NSMakeRange(loc + 1,len - 1)];
        }
    }
    
    // 把时间戳转化成时间
    NSTimeInterval interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}
- (IBAction)forgetPW:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    ForgetPWViewController *cvc = [board instantiateViewControllerWithIdentifier:@"ForgetPWViewController"];
    [self.navigationController pushViewController:cvc animated:YES];
}
- (BOOL)check{
    if (_phoneTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:self.view];
        return NO;
    }else{
        if (_pwTF.text.length == 0) {
             [MBProgressHUD showError:@"请输入密码" toView:self.view];
            return NO;
        }
        return YES;
    }
}
- (void)tap{
    [_phoneTF resignFirstResponder];
    [_pwTF resignFirstResponder];
}

@end
