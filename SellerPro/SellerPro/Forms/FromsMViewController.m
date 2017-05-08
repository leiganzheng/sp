//
//  FromsMViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "FromsMViewController.h"
#import "ContentViewController.h"
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
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

-(UIViewController *)tabContainer:(TabContainerViewController *)tabContainer contentViewControllerForTabAtIndex:(NSUInteger)index {
    ContentViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    
    cvc.labelString = [NSString stringWithFormat:@"Content View #%ld", index];
    
    return cvc;
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
            return [[UIColor whiteColor] colorWithAlphaComponent:0.32];
        case TabContainerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}
@end

