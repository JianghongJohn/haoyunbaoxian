//
//  VedioModel.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/25.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VedioModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *videoUrl;

@property (nonatomic, copy) NSString *videoDescription;

@property (nonatomic, assign) NSInteger orderNum;

@property (nonatomic, assign) long long createdTime;

@property (nonatomic, copy) NSString *updateBy;

@property (nonatomic, copy) NSString *displayPicUrl;

@property (nonatomic, assign) NSInteger playCount;

@property (nonatomic, assign) NSInteger isDel;

@property (nonatomic, assign) BOOL click;

@property (nonatomic, copy) NSString *createdBy;

@property (nonatomic, assign) NSInteger isValid;

@property (nonatomic, assign) NSInteger groupId;

@property (nonatomic, copy) NSString *videoName;

@property (nonatomic, assign) NSInteger clickCount;

@property (nonatomic, assign) long long updateTime;

@end
