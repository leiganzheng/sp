//
//  QRCodeViewController.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/10.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *veryBtn;
@property (weak, nonatomic) IBOutlet UIImageView *qrV;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackNavItem];
    [Tools QRCodeGenerator:self.qrV withUrl:[self.dict objectForKey:@"url"]];
    [self.veryBtn setTitle:[NSString stringWithFormat:@"二维码有效期：%@",[self.dict objectForKey:@"expires"]] forState:0];
    [self openCountdown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = (NSInteger)[self.dict objectForKey:@"expires"]-1; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.veryBtn setTitle:@"二维码到期" forState:UIControlStateNormal];
                [self.veryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.veryBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.veryBtn setTitle:[NSString stringWithFormat:@"二维码有效期：(%.2d)", seconds] forState:UIControlStateNormal];
                [self.veryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.veryBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


@end
