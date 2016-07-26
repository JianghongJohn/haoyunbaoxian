//
//  UserInfoModel.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/26.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *cityCode;

@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *mobileNo;

@property (nonatomic, copy) NSString *rejectReason;

@property (nonatomic, copy) NSString *inviterName;

@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, assign) NSInteger inviterId;

@end
