//
//  NickNameVC.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "BaseVC.h"

@interface NickNameVC : BaseVC
typedef void(^NickNameBlock)(NSString *);
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NickNameBlock nicknameBlock;
@end
