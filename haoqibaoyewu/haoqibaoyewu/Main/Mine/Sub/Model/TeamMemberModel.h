//
//  TeamMemberModel.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/14.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamMemberModel : NSObject


@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, copy) NSString *mobileNo;

@property (nonatomic, assign) CGFloat premium;

@property (nonatomic, assign) NSInteger policyCount;

@property (nonatomic, assign) NSInteger todayPremium;

@property (nonatomic, assign) NSInteger todayPolicyCount;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger state;

@end
