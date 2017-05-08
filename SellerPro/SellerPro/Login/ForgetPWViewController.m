//
//  ForgetPWViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "ForgetPWViewController.h"
#import "SettingPWViewController.h"
@interface ForgetPWViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgPhone;
@property (weak, nonatomic) IBOutlet UIView *bgCode;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation ForgetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码"; 
    [self setLeftBackNavItem];
    [Tools configCornerOfView:_bgPhone with:3];
    [Tools configCornerOfView:_bgCode with:3];
    [Tools configCornerOfView:_nextStep with:3];
    [Tools configCornerOfView:_codeBtn with:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextStepAction:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    SettingPWViewController *cvc = [board instantiateViewControllerWithIdentifier:@"SettingPWViewController"];
    [self.navigationController pushViewController:cvc animated:YES];
//
//    if (self.phoneTF.text.length != 0&&self.codeTF.text.length != 0) {
//        [DTNetManger checkVerifyCodeWith:self.phoneTF.text code:self.codeTF.text callBack:^(NSError *error, NSArray *response) {
//            
//        }];
//    }else{
//        if (self.phoneTF.text == 0) {
//            
//        }else{
//            
//        }
//    }

}


@end
