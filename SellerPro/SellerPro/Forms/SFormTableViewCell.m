//
//  SFormTableViewCell.m
//  SellerPro
//
//  Created by leiganzheng on 2017/5/9.
//  Copyright © 2017年 karashock. All rights reserved.
//

#import "SFormTableViewCell.h"

@implementation SFormTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Tools configCornerOfView:_bgView with:3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
