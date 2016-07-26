//
//  SquareCell.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareModel.h"
@interface SquareCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsPic;
@property (weak, nonatomic) IBOutlet UILabel *NewsTitle;

@property (weak, nonatomic) IBOutlet UILabel *newsDescription;

@property(nonatomic ,strong)SquareModel *model;
@end
