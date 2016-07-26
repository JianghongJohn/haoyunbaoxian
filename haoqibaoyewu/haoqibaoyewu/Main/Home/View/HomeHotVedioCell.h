//
//  HomeHotVedioCell.h
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/8.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VedioModel.h"
@interface HomeHotVedioCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *displayPic;
@property(nonatomic,strong)VedioModel *model;
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *discription;
@end
