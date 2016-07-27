//
//  InviterListCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/21.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "InviterListCell.h"

@implementation InviterListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(InviterModel *)model{
    if (_model != model) {
        _model = model;
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.headUrl] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
        _name.text = _model.name;
        
        _mobileNo.text = _model.mobileNo;
        
    }
    
    
}
@end
