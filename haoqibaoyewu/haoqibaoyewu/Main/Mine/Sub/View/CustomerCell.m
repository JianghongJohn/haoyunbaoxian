//
//  CustomerCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "CustomerCell.h"

@implementation CustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(CustomerDetailModel *)model{
    if (_model!=model) {
        _model = model;
        
        _orderNumLabel.text = [NSString stringWithFormat:@"%li",_model.orderId];
        _timeLabel.text = [NSString stringWithFormat:@"%i",_model.effectEndTime];
        _orderPriceLabel.text = [NSString stringWithFormat:@"%li",_model.premium];
        _licenceLabel.text = _model.licensePlateNumber;
    }
    
}
@end
