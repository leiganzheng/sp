//
//  FromsMViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "FromsMViewController.h"
#import "FPPopoverController.h"
#import "TimeViewController.h"
#import "SFormViewController.h"
#import "PersionViewController.h"
#import "ProgramViewController.h"

@interface FromsMViewController () <TabContainerDelegate,TabContainerDataSource>
@property (nonatomic) NSUInteger numberOfTabs;
@end

@implementation FromsMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    [self setLeftBackNavItem];
    self.title = @"业绩报表";
    self.numberOfTabs = 3;   ///////当设置数量时，去调用setter方法去加载控件
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"12月" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"home_btn_dropdown"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView.frame.size.width - btn.frame.size.width + btn.titleLabel.intrinsicContentSize.width, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -btn.titleLabel.frame.size.width - btn.frame.size.width + btn.imageView.frame.size.width);
    [btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)setNumberOfTabs:(NSUInteger)numberOfTabs {
    
    // Set numberOfTabs
    _numberOfTabs = numberOfTabs;
    
    // Reload data
    [self reloadData];
    
}


- (void)selectTabWithNumberThree {
    [self selectTabAtIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark --TabContainerDataSource
-(NSUInteger)numberOfTabsForTabContainer:(TabContainerViewController *)tabContainer {
    return self.numberOfTabs;
}

-(UIView *)tabContainer:(TabContainerViewController *)tabContainer viewForTabAtIndex:(NSUInteger)index {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15.0];
    if (index == 0) {
        label.text = @"服务单";
    }
    if (index == 1) {
        label.text = @"个人榜";
    }
    if (index == 2) {
        label.text = @"项目榜";
    }

    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    
    return label;
}

-(UIViewController *)tabContainer:(TabContainerViewController *)tabContainer contentViewControllerForTabAtIndex:(NSUInteger)index {
    if (index == 0) {
        SFormViewController *cvc = [[SFormViewController alloc] init];
        return cvc;
    }else if (index == 1){
        PersionViewController *cvc = [[PersionViewController alloc] init];
        return cvc;
    }else{
        ProgramViewController *cvc = [[ProgramViewController alloc] init];
        return cvc;
    }
}
#pragma mark -- private method
- (void)select:(UIButton*)sender{
    TimeViewController *vc = [[TimeViewController alloc]init];
    FPPopoverController*popover = [[FPPopoverController alloc] initWithViewController:vc];
    popover.contentSize = CGSizeMake(200, 300);
    popover.arrowDirection = UIMenuControllerArrowUp;
    [popover presentPopoverFromView:sender];
}

#pragma mark --TabContainerDelegate
-(CGFloat)heightForTabInTabContainer:(TabContainerViewController *)tabContainer {
    return 44;
}

-(UIColor *)tabContainer:(TabContainerViewController *)tabContainer colorForComponent:(TabContainerComponent)component withDefault:(UIColor *)color {
    switch (component) {
        case TabContainerIndicator:
            return [RGB(17, 157, 255) colorWithAlphaComponent:1];
        case TabContainerTabsView:
            return [[UIColor blackColor] colorWithAlphaComponent:1];
        case TabContainerContent:
            return [[UIColor whiteColor] colorWithAlphaComponent:1];
        default:
            return color;
    }
}
@end

