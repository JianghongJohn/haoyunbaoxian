//
//  AppDelegate.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/4.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "BaseTabBarVC.h"
#import "LoginVC.h"
#import "UserInfoSingle.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //启动IQkeyBoard
    [self _startIQKeyBoard];
    //设置导航栏
    [self _setAppearance];
    //设置根视图
    [self _setRootWindows];
    
    return YES;
}



-(void)_startIQKeyBoard{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}
-(void)_setRootWindows{
    /*-------->设置窗口<--------*/
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    设置窗口背景为主背景色,处理了某些动画会出现短暂黑色背景的尴尬
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //获取本地token
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:JH_Token]==nil) {
        LoginVC *login = [[LoginVC alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = navigation;
    }else{
       
        [[UserInfoSingle sharedInstance] getUserInfo];
        
        BaseTabBarVC *rootTabBar = [[BaseTabBarVC alloc]init];
        self.window.rootViewController = rootTabBar;
    }
}
-(void)_setAppearance{
    /************ 控件外观设置 **************/
    //导航栏
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
//    //隐藏返回按钮上的文字
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
//                                                         forBarMetrics:UIBarMetricsDefault];

    
    //设置输入框
    [[UITextField appearance]setTintColor:[UIColor redColor]];
    [[UISearchBar appearance]setTintColor:[UIColor redColor]];
    
    //设置进度框
    [[SVProgressHUD appearance]setDefaultStyle:SVProgressHUDStyleCustom];
    [[SVProgressHUD appearance]setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    [[SVProgressHUD appearance]setForegroundColor:[UIColor redColor]];
    

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
