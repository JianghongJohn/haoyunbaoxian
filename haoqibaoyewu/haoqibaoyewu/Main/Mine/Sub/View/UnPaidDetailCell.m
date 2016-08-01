//
//  UnPaidDetailCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/8/1.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "UnPaidDetailCell.h"

@implementation UnPaidDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(UnPaidModel *)model{
    if (_model != model) {
        _model = model;
        
        _relayCount.text = [NSString stringWithFormat:@"%li家报价",_model.replyCount];
        _minPremium.text = [NSString stringWithFormat:@"%li",_model.minPremium];
        _quotationTime.text = [NSString stringWithFormat:@"%li",_model.quotationTime];
        
    }
    
}
@end
