//
//  UnPaidDetailCell.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/8/1.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnPaidModel.h"
@interface UnPaidDetailCell : UITableViewCell
@property(nonatomic,strong)UnPaidModel *model;
@property (weak, nonatomic) IBOutlet UILabel *relayCount;
@property (weak, nonatomic) IBOutlet UILabel *minPremium;
@property (weak, nonatomic) IBOutlet UILabel *quotationTime;
@end
