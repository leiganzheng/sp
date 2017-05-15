//
//  DetailServiceViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/15.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "DetailServiceViewController.h"
#import "DddSeviceViewController.h"

@interface DetailServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation DetailServiceViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-108) style:UITableViewStylePlain];
        _myTableView.rowHeight = 52;
        _myTableView.delegate   = self;
        _myTableView.dataSource = self;
        _myTableView.backgroundColor = [UIColor clearColor];
       
        [_myTableView registerClass:[MGSwipeTableCell class] forCellReuseIdentifier:kDTMyCellIdentifier];
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务项目";
    [self setLeftBackNavItem];
    
    [self.view addSubview:self.myTableView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, KSCREEN_HEIGHT-108, KSCREEN_WIDTH, 44);
    [btn setTitle:@"添加新项目" forState:UIControlStateNormal];
    btn.backgroundColor = RGB(17, 157, 255);
    [btn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
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
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(4, 2, KSCREEN_WIDTH - 8, 48);
    [Tools configCornerOfView:bgView with:3];
    [cell.contentView addSubview:bgView];
    
    UIImageView *redV = [[UIImageView alloc] init];
    redV.frame = CGRectMake(4, 2, 4, 48);
    redV.image = [UIImage imageNamed:@"program_img_strip"];
    [Tools configCornerOfView:redV with:3];
    [cell.contentView addSubview:redV];
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 210, 4, 200, 40)];
    lb.text = [dic objectForKey:@"price"];
    lb.textAlignment = NSTextAlignmentRight;
    lb.textColor = [UIColor redColor];
    [bgView addSubview:lb];
    
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(8, 4, 200, 40)];
    lb1.text = [dic objectForKey:@"name"];
    lb1.textAlignment = NSTextAlignmentLeft;
    lb1.textColor = [UIColor blackColor];
    [bgView addSubview:lb1];

        cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"删除" icon:[UIImage imageNamed:@""] backgroundColor:[UIColor redColor]]];
        cell.leftSwipeSettings.transition = MGSwipeTransition3D;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MGSwipeTableCell *myCell = (MGSwipeTableCell *)cell;
//    NSDictionary *dic = self.dataSource[indexPath.row];
//    myCell.textLabel.text = [dic objectForKey:@"name"];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - private action
- (void)add:(UIButton*)sender{
    DddSeviceViewController *vc = [[DddSeviceViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
