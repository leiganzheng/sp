//
//  TimeViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/8.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "TimeViewController.h"
#import "DTMyTableViewCell.h"

@interface TimeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation TimeViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 300) style:UITableViewStylePlain];
        _myTableView.rowHeight = 40;
        _myTableView.delegate   = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = RGB(249, 249, 249);
        _myTableView.separatorColor = DT_Base_LineColor;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDTMyCellIdentifier];
    }
    return _myTableView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"1月",@"1月",@"1月",@"1月"];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择月份";
    [self setLeftBackNavItem];
    [self.view addSubview:self.myTableView];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = (UITableViewCell *)cell;
    myCell.textLabel.text = self.dataSource[indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - private action
// 免责声明
@end
