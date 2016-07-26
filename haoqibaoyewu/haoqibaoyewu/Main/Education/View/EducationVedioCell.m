//
//  EducationVedioCell.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/8.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "EducationVedioCell.h"

@implementation EducationVedioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _userName.layer.borderColor = [UIColor grayColor].CGColor;
    _userName.layer.borderWidth = 1;
//    [_likeButton setImage:[UIImage imageCompressWithSimple:[UIImage imageNamed:@"grey"] scaledToSize:CGSizeMake(20, 20)] forState:0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)likeAction:(UIButton *)sender {
    
}


-(void)setModel:(VedioModel *)model{
    if (_model!=model) {
        _model=model;
        [_baseImage sd_setImageWithURL:[NSURL URLWithString:_model.displayPicUrl] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
        _videoName.text = _model.videoName;
        
        _descriptionLabel.text = _model.videoDescription;
        
        _userName.text = _model.createdBy;
        
        [_likeButton setTitle:[NSString stringWithFormat:@"%li",_model.clickCount] forState:0];
        
        
        /**
         *  处理是否点赞
         */
        if (_model.click) {
            
            [_likeButton setImage:[UIImage imageCompressWithSimple:[UIImage imageNamed:@"red"] scaledToSize:CGSizeMake(20, 20)] forState:0];
        }else{
              [_likeButton setImage:[UIImage imageCompressWithSimple:[UIImage imageNamed:@"grey"] scaledToSize:CGSizeMake(20, 20)] forState:0];
        }
        
        
        
    }
}
@end
