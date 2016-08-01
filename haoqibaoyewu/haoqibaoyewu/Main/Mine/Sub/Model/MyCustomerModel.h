//
//  MyCustomerModel.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/8/1.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCustomerModel : NSObject
@property(nonatomic,copy)NSString *customerName;
@property(nonatomic,copy)NSString *customerSex;
@property(nonatomic,copy)NSString *licensePlateNumber;
@property(nonatomic,assign)int effectEndTime;
@property(nonatomic,assign)long customerId;
@property(nonatomic,assign)long vehicleId;
@property(nonatomic,assign)long quotationTime;
@property(nonatomic,assign)long premium;


@end
