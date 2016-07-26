//
//  UserInfoSingle.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/19.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "UserInfoSingle.h"

@implementation UserInfoSingle

static UserInfoSingle* _instance = nil;

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
        
    }) ;
    
    return _instance ;
}
/**
 OBJC_SWIFT_UNAVAILABLE("use object initializers instead")
 +(id) allocWithZone:(struct _NSZone *)zone
 {
 return [UserInfoSingle sharedInstance] ;
 }
 
 -(id) copyWithZone:(struct _NSZone *)zone
 {
 return [UserInfoSingle sharedInstance] ;
 }
 */

//+(void)initialize{
//    [UserInfoSingle sharedInstance] ;
//}
-(void)setPhoneNum:(NSString *)phoneNum{
    
    [[NSUserDefaults standardUserDefaults]setObject:phoneNum forKey:JH_UserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)setUserId:(NSString *)userId{
    [[NSUserDefaults standardUserDefaults]setObject:userId forKey:JH_UserId];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)setToken:(NSString *)token{
    
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:JH_Token];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
/**
 *  加载本地的信息，只有在token存在的时候才能够调用这个方法
 */
-(void)getUserInfo;{
    NSLog(@"%@",[NSString stringWithFormat:@"%@/Library",NSHomeDirectory()]);
    _instance.userId = [[NSUserDefaults standardUserDefaults]objectForKey:JH_UserId];
    _instance.phoneNum = [[NSUserDefaults standardUserDefaults]objectForKey:JH_UserPhone];
    _instance.token = [[NSUserDefaults standardUserDefaults]objectForKey:JH_Token];
}

@end
