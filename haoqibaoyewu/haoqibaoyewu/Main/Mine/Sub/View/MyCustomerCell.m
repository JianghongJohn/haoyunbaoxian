//
//  MyCustomerCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyCustomerCell.h"

@implementation MyCustomerCell

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
            
            _sexImage.image = [UIImage imageNamed:@"男"];
        }
        _licenseNum.text = _model.licensePlateNumber;
        
    }
    
}
@end
