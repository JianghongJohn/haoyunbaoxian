//
//  TeamMemberModel.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/14.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamMemberModel : NSObject
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *realName;
@property(nonatomic,assign)BOOL isAlive;

@end
