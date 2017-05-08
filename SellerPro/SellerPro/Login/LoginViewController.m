//
//  LoginViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPWViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Tools configCornerOfView:_login with:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    [DTNetManger loginWith:@"18682242936" PW:@"123" callBack:^(NSError *error, NSArray *response) {
        
    }];
}
- (IBAction)forgetPW:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    ForgetPWViewController *cvc = [board instantiateViewControllerWithIdentifier:@"ForgetPWViewController"];
    [self.navigationController pushViewController:cvc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
