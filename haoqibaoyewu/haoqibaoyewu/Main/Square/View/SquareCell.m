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

-(void)setModel:(SquareModel *)model{
    if (_model!=model) {
        _model=model;
        //图片
        [_newsPic sd_setImageWithURL:[NSURL URLWithString:_model.background] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
        //标题
        _NewsTitle.text = _model.name;
        
        //描述
        _newsDescription.text = _model.newsDescription;
    }
}
@end


