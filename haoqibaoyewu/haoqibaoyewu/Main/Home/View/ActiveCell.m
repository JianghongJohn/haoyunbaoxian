//
//  ActiveCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/21.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "ActiveCell.h"

@implementation ActiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImageUrl:(NSString *)imageUrl{
    
    if (_imageUrl!=imageUrl) {
        _imageUrl = imageUrl;
        
        [_webImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
    }
    
}

@end
