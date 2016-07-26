//
//  SquareModel.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/26.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SquareModel : NSObject

@property (nonatomic, assign) NSInteger isVaild;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, assign) long long updateTime;

@property (nonatomic, copy) NSString *background;

@property (nonatomic, assign) long long endTime;

@property (nonatomic, copy) NSString *media;

@property (nonatomic, assign) NSInteger activityId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, assign) long long createdTime;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger isDel;

@property (nonatomic, copy) NSString *createBy;

@property (nonatomic, copy) NSString *updateBy;

@property (nonatomic, copy) NSString *tpl;

@property (nonatomic, assign) long long displayTime;

@property (nonatomic, assign) long long startTime;

@property (nonatomic, copy) NSString *activityArea;

@property (nonatomic, copy) NSString *newsDescription;

@end
