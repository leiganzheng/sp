//
//  DddSeviceViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/8.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "DddSeviceViewController.h"
#import "DTMyTableViewCell.h"

@interface DddSeviceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *dataSource1;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

static NSString *const kDTMyCellIdentifier = @"myCellIdentifier";
@implementation DddSeviceViewController
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-108) style:UITableViewStyleGrouped];
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
        _dataSource = @[@[@"项目名称",@"单价(元／次)",@"类别"],@[@"权限一",@"权限二",@"权限三",@"权限四"]];
        _dataSource1 = @[@"打蜡洗车",@"¥500.0",@"美容"];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加项目";
    [self setLeftBackNavItem];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.myTableView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, KSCREEN_HEIGHT-108, KSCREEN_WIDTH, 44);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.backgroundColor = RGB(17, 157, 255);
    [btn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
-(void)save:(UIButton *)sender{
    
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray*)self.dataSource[section]).count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return  0.01;
    }else{
        return 40;
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return  @"";
    }else{
        return @"请指定权限组";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTMyCellIdentifier];
    if (indexPath.section == 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH-230, 0, 240, 40)];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        NSString *str = _dataSource1[indexPath.row];
        lb.text = str;
        lb.text = @"类别";
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
       
    }else{
        UIImageView *redV = [[UIImageView alloc] init];
        redV.frame = CGRectMake(0, 0, 22, 22);
        redV.image = [UIImage imageNamed:@"staffmanagement_btn_option_seleted"];
        [Tools configCornerOfView:redV with:3];
        cell.accessoryView = redV;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGSwipeTableCell *myCell = (MGSwipeTableCell *)cell;
    myCell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - private action

@end

