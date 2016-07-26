//
//  ServeCell.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/15.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServeModel.h"
@interface ServeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thisImageView;

@property(nonatomic,strong)ServeModel *model;
@end
