//
//  HomeHotVedioCell.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/8.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "HomeHotVedioCell.h"

@implementation HomeHotVedioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(VedioModel *)model{
    if (_model!=model) {
        _model=model;
        [_displayPic sd_setImageWithURL:[NSURL URLWithString:_model.displayPicUrl] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
        _videoName.text = _model.videoName;
        
        _discription.text = _model.videoDescription;
        
        
    }
    
}
@end
