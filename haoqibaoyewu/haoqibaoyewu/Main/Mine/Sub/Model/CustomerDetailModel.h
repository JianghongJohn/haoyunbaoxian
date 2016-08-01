//
//  CustomerDetailModel.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/8/1.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerDetailModel : NSObject
@property(nonatomic,copy)NSString *policyNo;

@property(nonatomic,copy)NSString *licensePlateNumber;
@property(nonatomic,assign)int effectEndTime;
@property(nonatomic,assign)long orderId;
@property(nonatomic,assign)long premium;

@end
