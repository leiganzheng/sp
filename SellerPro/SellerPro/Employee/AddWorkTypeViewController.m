//
//  AddWorkTypeViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/10.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "AddWorkTypeViewController.h"

@interface AddWorkTypeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation AddWorkTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackNavItem];
    if (!self.isAdd) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"staffmanagement_btn_deleted"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 44, 44);
        [btn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        if (self.nameStr) {
            _name.text = self.nameStr;
               self.title = @"添加工种";
        }else{
            self.workType = @"";
            self.title = @"修改工种";
        }
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
   
}
- (void)tap{
    [_name resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender {
    if (self.name.text.length ==0 ) {
        [MBProgressHUD showError:@"输入内容" toView:self.view];
        return;
    }
    [DTNetManger addWorkTypeWith:self.workType name:self.name.text callBack:^(NSError *error, id response) {
        if (response) {
            [MBProgressHUD showError:@"提交成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:error.description toView:self.view];
        }

    }];
}
-(void)delete:(id)sender{
    [DTNetManger delWorkTypeWith:self.workType callBack:^(NSError *error, id response) {
        if (response) {
            [MBProgressHUD showError:@"删除成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:error.description toView:self.view];
        }
    }];
}


@end
