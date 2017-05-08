//
//  SettingPWViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "SettingPWViewController.h"
#import "LoginViewController.h"
@interface SettingPWViewController ()

@end

@implementation SettingPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackNavItem];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneAction:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    LoginViewController *cvc = [board instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:cvc animated:YES completion:^{
        
    }];
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
