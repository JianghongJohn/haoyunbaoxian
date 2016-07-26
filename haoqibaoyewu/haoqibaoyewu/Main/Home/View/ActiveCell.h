//
//  ActiveCell.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/21.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *webImageView;

@property(nonatomic,copy)NSString *imageUrl;

@end
