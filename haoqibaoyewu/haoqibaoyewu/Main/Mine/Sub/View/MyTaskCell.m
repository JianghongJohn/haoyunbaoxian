//
//  MyTaskCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/14.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyTaskCell.h"

@implementation MyTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _persentView.persent = 0.33;
    _persentView.font = SYSFONT12;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
