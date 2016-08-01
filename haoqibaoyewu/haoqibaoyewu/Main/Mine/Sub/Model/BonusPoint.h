//
//  BonusPoint.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/8/1.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BonusPoint : NSObject
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *plusOrMinus;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,assign)long amount;

@end
