//
//  StaffInfoViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/8.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "StaffInfoViewController.h"
#import "DTMyTableViewCell.h"
#import "StaffInfoMdViewController.h"
#import "AuthorSettingViewController.h"
#import "StaffInfoTableViewCell.h"

@interface StaffInfoViewController ()<UITableViewDelegate,UITableViewDataSource,StaffInfoMdViewControllerDelegate>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *dataSource1;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (nonatomic,strong) NSString *flagStr;
@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation StaffInfoViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 265) style:UITableViewStylePlain];
        _myTableView.rowHeight = 52;
        _myTableView.delegate   = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor clearColor];

       [_myTableView registerNib:[UINib nibWithNibName:@"StaffInfoTableViewCell" bundle:nil] forCellReuseIdentifier:kDTMyCellIdentifier];
    }
    return _myTableView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"员工姓名",@"联系方式",@"员工职位",@"就职状态",@"设置独立权限"];
//        _dataSource1 = @[@"物件",@"13545678907",@"洗车工",@"在职",@""];
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
    [self featchData];
}

#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaffInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaffInfoTableViewCell *myCell = (StaffInfoTableViewCell *)cell;
    myCell.name.text = self.dataSource[indexPath.row];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH-230, 0, 240, 40)];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    NSString *str = _dataSource1[indexPath.row];
    lb.text = str;
    if (indexPath.row == 2) {
        lb.text = self.workStr;
    }
    if (indexPath.row == 3) {
        self.flagStr = str;
        lb.text = self.flagStr.integerValue ==0 ? @"在职" : @"离职";
    }
    
    lb.textAlignment = NSTextAlignmentRight;
    lb.textColor = [UIColor lightGrayColor];
    [v addSubview:lb];
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(200, 9, 22, 22);
        [btn setImage:[UIImage imageNamed:@"home_btn_next"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        [v addSubview:btn];

    }
//    cell.accessoryView = v;
    [myCell.contentView addSubview:v];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row ==2) {
        StaffInfoMdViewController *vc = [[StaffInfoMdViewController alloc]init];
        vc.isWorkType = YES;
        vc.cusID = _dataSource1[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row ==3) {
        StaffInfoMdViewController *vc = [[StaffInfoMdViewController alloc]init];
        vc.isWorkType = NO;
        vc.cusID = _dataSource1[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row ==4) {
         [MBProgressHUD showError:@"功能开发中" toView:self.view];
        return ;
        if (self.flagStr.integerValue == 1) {
            [MBProgressHUD showError:@"离职状态，无法设置权限" toView:self.view];
        }else{
        AuthorSettingViewController *vc = [[AuthorSettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        }
    }

}
-(void)didSelectedData:(NSString *)data withType:(BOOL)falg{
    if (falg) {
        self.workStr = data;
    }else{
        self.flagStr = data;
    }
    [self.myTableView reloadData];
}
#pragma mark - private action
-(void)save:(UIButton *)sender{
    
}
-(void)featchData{
    if (self.staffID&&self.staffID.length != 0) {
        [DTNetManger getStaffInfoWith:self.staffID callBack:^(NSError *error, id response) {
            if (response && [response isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary*)response;
                _dataSource1 = @[[dict objectForKey:@"name"],[dict objectForKey:@"phone"],[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_type_id"]],[NSString stringWithFormat:@"%@",[dict objectForKey:@"is_disabled"]],@""];
                [_myTableView reloadData];
            }else{
                if ([response  isKindOfClass:[NSString class]]) {
                    [MBProgressHUD showError:(NSString *)response toView:self.view];
                    [self.myTableView.mj_header endRefreshing];
                }
            }
            
        }];
    }
    
}
@end
