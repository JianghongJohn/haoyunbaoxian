//
//  SquareCell.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/8.
//  Copyright © 2016年 jianghong. All rights reserved.
//
#import "SquareCell.h"
@implementation SquareCell
- (void)awakeFromNib {
    [super awakeFromNib];
    _hotLabel.layer.cornerRadius = 5;
    _hotLabel.layer.borderWidth = 1;
    _hotLabel.layer.borderColor = [UIColor redColor].CGColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end


