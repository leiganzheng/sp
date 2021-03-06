//
//  DTBaseViewController.m
//
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTBaseViewController.h"

@interface DTBaseViewController ()

@end

@implementation DTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGB(243, 240, 246);
    if (!kStringIsEmpty(_navTitle)) {
        self.title = _navTitle;
    }
}
#pragma mark - hide NavBar
- (void)hideNavBar:(BOOL)isHide
{
    [self.navigationController setNavigationBarHidden:isHide];
}
#pragma mark - setLeftBackNavItem
- (void)setLeftBackNavItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 30);
    [btn setImage:[UIImage imageNamed:@"staffmanagement_btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
#pragma mark - doBack
- (void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
