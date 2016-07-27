//
//  MyHeadPortrait.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "BaseVC.h"
typedef void(^ImageBlock)(NSString *);
@interface MyHeadPortrait : BaseVC
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)ImageBlock imageBlock;
@end
