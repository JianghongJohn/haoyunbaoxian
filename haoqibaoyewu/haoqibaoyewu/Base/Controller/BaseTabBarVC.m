//
//  BaseTabBarVC.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/5.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "HomeVC.h"
#import "EducationVC.h"
#import "SquareVC.h"
#import "MineVC.h"
@interface BaseTabBarVC ()

@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        self.view.alpha = 1;
    }];
    
    [self _setUpAllChildViewController];
}
/**
 *  添加所有子控制器方法
 */
- (void)_setUpAllChildViewController{
    //设置标签栏选中默认颜色
      self.tabBar.tintColor = [UIColor redColor];
    
    // 1.添加第一个控制器
    HomeVC *home = [[HomeVC alloc]init];
    // 2.添加第2个控制器
    EducationVC *education = [[EducationVC alloc]init];
    // 3.添加第3个控制器
    SquareVC *square = [[SquareVC alloc]init];
    // 4.添加第4个控制器
    MineVC *mine = [[MineVC alloc]init];
    
    NSArray *image_on_name = @[@"home-on",@"education-on",@"square-on",@"mine-on"];
    NSArray *image_off_name = @[@"home-off",@"education-off",@"square-off",@"mine-off"];
    NSArray *names = @[@"首页",@"教育",@"广场",@"我的"];
    
    NSArray *baseVC = @[home,education,square,mine];
    
  
    //设置控制器
    for (int i = 0; i<names.count;i++ ) {
        
        [self _setUpOneChildViewController:baseVC[i] image:[UIImage imageNamed:image_off_name[i]] selectedImage:[UIImage imageNamed:image_on_name[i] ] title:names[i]];
    }
    
}

/**
 *  添加一个子控制器的方法
 */
- (void)_setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = image;
    navC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
    viewController.navigationItem.title = title;
    
    [self addChildViewController:navC];
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
