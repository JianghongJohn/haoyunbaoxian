//
//  MyPointCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyPointCell.h"

@implementation MyPointCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(BonusPoint *)model{
    if (_model!=model) {
        _model = model;
        
        _typeLabel.text = _model.type;
        _timeLabel.text = [NSString stringWithFormat:@"%@",_model.createTime];
        _pointLabel.text = [NSString stringWithFormat:@"%li",_model.amount];
    }
    
}

@end
