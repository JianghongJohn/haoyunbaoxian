//
//  JH_NetWorking.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/22.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JH_NetWorking : NSObject
//使用NSURLSession组件来做网络申请
+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method  params:(NSMutableDictionary *)params completionHandle:(void(^)(id result))completionblock errorHandle:(void(^)(NSError *error))errorblock;
@end
