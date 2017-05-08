//
//  ServiceViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/7.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "ServiceViewController.h"
#import "DTMyTableViewCell.h"

@interface ServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation ServiceViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _myTableView.rowHeight = 80;
        _myTableView.delegate   = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = RGB(249, 249, 249);
        _myTableView.separatorColor = DT_Base_LineColor;
        [_myTableView registerClass:[DTMyTableViewCell class] forCellReuseIdentifier:kDTMyCellIdentifier];
    }
    return _myTableView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"服务项目-",@"服务项目-",@"服务项目-",@"服务项目-"];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务项目";
    [self setLeftBackNavItem];
    [self.view addSubview:self.myTableView];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMyTableViewCell *myCell = (DTMyTableViewCell *)cell;
    myCell.titleLabel.textColor = DT_Base_TitleColor;
    myCell.iconView.hidden = NO;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //    myCell.iconView.image = [UIImage imageNamed:@"dt_tabbar_make_selete"];
    myCell.titleLabel.text = self.dataSource[indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - private action
// 免责声明
@end


