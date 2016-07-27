//
//  JH_NetWorking.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/22.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "JH_NetWorking.h"
#import "UserInfoSingle.h"
#define BaseURL @"http://114.55.157.62:8082/bcis/api/m/"

@implementation JH_NetWorking

+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock{
    
    //1.拼接URL
    NSString *requestString = [BaseURL stringByAppendingString:urlString];
    requestString = [requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //发送异步网络请求
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
//    [manager.requestSerializer setValue:@"application/json; charset=gb2312" forHTTPHeaderField:@"Content-Type" ];
    ;
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:JH_Token];
    /**
     *  添加token
     */
    [manager.requestSerializer setValue: token forHTTPHeaderField:@"token" ];
    //
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
 /**
   *  开启进度条
   */
 

    [SVProgressHUD show];
    //GET和POST分别处理
    if ([method isEqualToString:@"GET"]) {
        [manager GET:requestString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *result = responseObject;
//            NSLog(@"返回成功%@",result);

            NSNumber *errorCode = result[@"errorCode"];
            
//处理token过期的情况
            if ([errorCode isEqual:@300]) {
                NSLog(@"登陆过期");
                //打开
                //发送通知
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:JH_TokenExpired object:nil userInfo:nil];
                });
            }
            
            completionblock(responseObject);
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 /**
  *  关闭进度条
  */
    [SVProgressHUD showErrorWithStatus:@"网络或服务器连接错误"];
    
            
            errorblock(error);
            NSLog(@"失败%@",error);
        }];
        
    }
    else if([method isEqualToString:@"POST"]) {
        
        [manager POST:requestString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功%@",responseObject);
            
            completionblock(responseObject);
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            errorblock(error);
            NSLog(@"失败%@",error);
        }];
        
        
    }
    
}
@end
