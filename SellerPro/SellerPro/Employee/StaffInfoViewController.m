//
//  StaffInfoViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/8.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "StaffInfoViewController.h"
#import "DTMyTableViewCell.h"

@interface StaffInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *dataSource1;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation StaffInfoViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-108) style:UITableViewStyleGrouped];
        _myTableView.rowHeight = 52;
        _myTableView.delegate   = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor clearColor];
        [_myTableView registerClass:[MGSwipeTableCell class] forCellReuseIdentifier:kDTMyCellIdentifier];
    }
    return _myTableView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"员工姓名",@"联系方式",@"员工职位",@"就职状态",@"设置独立权限"];
        _dataSource1 = @[@"物件",@"13545678907",@"洗车工",@"在职",@""];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"员工信息";
    [self setLeftBackNavItem];
    [self.view addSubview:self.myTableView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, KSCREEN_HEIGHT-108, KSCREEN_WIDTH, 44);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.backgroundColor = RGB(17, 157, 255);
    [btn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        lb.text = _dataSource1[indexPath.row];
        lb.textAlignment = NSTextAlignmentRight;
        lb.textColor = [UIColor lightGrayColor];
        cell.accessoryView = lb;
        if (indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGSwipeTableCell *myCell = (MGSwipeTableCell *)cell;
    myCell.textLabel.text = self.dataSource[indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - private action
-(void)save:(UIButton *)sender{
    
}
@end
