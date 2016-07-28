//
//  BaseVC.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/5.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "BaseVC.h"
#import "LoginVC.h"
#import "AppDelegate.h"
@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //使用统一的背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgImageView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    
        
        [self _receivedNotification];
   
    
}
//push操作
-(void)_pushViewController:(UIViewController *)controller;{
    controller.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
}

/**
 *  添加通知的处理方式
 */
-(void)_receivedNotification{
    //移除相对应的数据

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginAction) name:JH_TokenExpired object:nil];
    
}
/**
 *  重新登陆
 */
-(void)loginAction{
    
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:JH_Token]!=nil) {
    
    LoginVC *login = [[LoginVC alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:login];
    
    
    AppDelegate *appdelegate = APPDELEGATE;
    
    appdelegate.window.rootViewController = navigation;
    
        //token//openId//userId//UserPhone
//        //
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_TokenOnce];
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_Token];
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_OpenId];
//        
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_UserId];
//        
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_UserPhone];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
   
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
