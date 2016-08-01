//
//  UnPaidCustomerCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/8/1.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "UnPaidCustomerCell.h"

@implementation UnPaidCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MyCustomerModel *)model{
    if (_model!=model) {
        _model = model;
        
        _nameLabel.text = _model.customerName;
        _timeLabel.text = [NSString stringWithFormat:@"%i",_model.effectEndTime];
        if ([_model.customerSex isEqualToString:@"male"]) {
            
            _sexLabel.image = [UIImage imageNamed:@"男"];
        }
        _licenseLabel.text = _model.licensePlateNumber;
        
        _priceLabel.text = [NSString stringWithFormat:@"%li",_model.premium];
    }
    
}
@end
