//
//  CustomerCell.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerDetailModel.h"
@interface CustomerCell : UITableViewCell
@property(nonatomic,strong)CustomerDetailModel *model;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *licenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
