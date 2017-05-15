//
//  StaffInfoMdViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/14.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "StaffInfoMdViewController.h"
#import "DTMyTableViewCell.h"

@interface StaffInfoMdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *flagArr;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation StaffInfoMdViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-108) style:UITableViewStylePlain];
        _myTableView.rowHeight = 52;
        _myTableView.delegate   = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.separatorColor = DT_Base_LineColor;
        [_myTableView registerClass:[MGSwipeTableCell class] forCellReuseIdentifier:kDTMyCellIdentifier];
    }
    return _myTableView;
}
- (NSArray *)dataSource
{
    if (!_dataSource) {
        if (_isWorkType) {
            _dataSource = @[@"洗车工",@"维修工"];
        }else{
            _dataSource = @[@"在职",@"离职"];
        }
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBackNavItem];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.myTableView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, KSCREEN_HEIGHT-108, KSCREEN_WIDTH, 44);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.backgroundColor = RGB(17, 157, 255);
    [btn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    if (_isWorkType) {
        self.title = @"选择职位";
//        _dataSource = @[@"洗车工",@"维修工"];
    }else{
        self.title = @"设置工作状态";
//         _dataSource = @[@"洗车工",@"维修工"];
    }
}
-(void)save:(UIButton *)sender{
    
}

#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section ==0) {
//        return  0.01;
//    }else{
//        return 40;
//    }
//}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section ==0) {
//        return  @"";
//    }else{
//        return @"请指定权限组";
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
    if (indexPath.section == 0) {
//        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
//        lb.textAlignment = NSTextAlignmentRight;
//        lb.textColor = [UIColor lightGrayColor];
//        cell.accessoryView = lb;
//        if (indexPath.row == 2) {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
        UIImageView *redV = [[UIImageView alloc] init];
        redV.frame = CGRectMake(0, 0, 22, 22);
        if (!_isWorkType) {
            NSString *str = ((NSString *)self.dataSource[indexPath.row]).integerValue == 0 ? @"staffmanagement_btn_option_seleted" : @"staffmanagement_btn_option_unseleted";
            redV.image = [UIImage imageNamed:str];
        }
        redV.image = [UIImage imageNamed:@"staffmanagement_btn_option_seleted"];
        [Tools configCornerOfView:redV with:3];
        cell.accessoryView = redV;

        
    }
//    else{
//        UIImageView *redV = [[UIImageView alloc] init];
//        redV.frame = CGRectMake(0, 0, 22, 22);
//        redV.image = [UIImage imageNamed:@"staffmanagement_btn_option_seleted"];
//        [Tools configCornerOfView:redV with:3];
//        cell.accessoryView = redV;
//    }
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

@end

