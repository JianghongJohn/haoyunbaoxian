//
//  UserInfoSingle.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/19.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoSingle : NSObject

+(instancetype)sharedInstance;

-(void)getUserInfo;
//手机
@property(nonatomic,copy)NSString *phoneNum;
//验证码
@property(nonatomic,copy)NSString *checkNum;
//token
@property(nonatomic,copy)NSString *token;
//token
@property(nonatomic,copy)NSString *userId;
@end
