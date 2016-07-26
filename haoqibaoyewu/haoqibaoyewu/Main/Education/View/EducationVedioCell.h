//
//  EducationVedioCell.h
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/8.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VedioModel.h"
@interface EducationVedioCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *baseImage;
@property (weak, nonatomic) IBOutlet UILabel *videoName;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
- (IBAction)likeAction:(UIButton *)sender;
//视频Model
@property(nonatomic,strong)VedioModel *model;
@end
