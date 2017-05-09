//
//  WorkTypeViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/8.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "WorkTypeViewController.h"
#import "DTMyTableViewCell.h"

@interface WorkTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *iconSource;

@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation WorkTypeViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-144) style:UITableViewStylePlain];
        _myTableView.rowHeight = 100;
        _myTableView.delegate   = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.separatorColor = DT_Base_LineColor;
        [_myTableView registerClass:[DTMyTableViewCell class] forCellReuseIdentifier:kDTMyCellIdentifier];
    }
    return _myTableView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"洗车工",@"维修工",@"打蜡工"];
    }
    return _dataSource;
}
- (NSArray *)iconSource
{
    if (!_iconSource) {
        _iconSource = @[@"home_icon_form",@"home_btn_staff",@"home_btn_servement",@"home_btn_password_setting"];
    }
    return _iconSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMyTableViewCell *myCell = (DTMyTableViewCell *)cell;
    myCell.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    myCell.titleLabel.textColor = DT_Base_TitleColor;
    myCell.iconView.hidden = NO;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    myCell.iconView.image = [UIImage imageNamed:self.iconSource[indexPath.row]];
    myCell.titleLabel.text = self.dataSource[indexPath.row];
}

@end

