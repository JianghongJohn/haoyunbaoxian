//
//  LoginVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/21.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "LoginVC.h"
#import "BaseTabBarVC.h"
#import "AppDelegate.h"
#import "UserInfoSingle.h"
@interface LoginVC ()

{
    UIButton *_checkNumButton;
    NSTimer *_timer;
    NSInteger _countDown;
    UITextField *_phoneText;
    UITextField *_checkText;
    
}
@end

@implementation LoginVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
    
    [self _creatTextView];
    
    [self _creatSecondView];
    
    [self _creatBottomView];
    
}

-(void)_creatTextView{
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+kTopBarHeight, SCREENWIDTH, 100)];
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    
    //手机号
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 55, 30)];
    phoneLabel.text = @"手机号";
    [textView addSubview:phoneLabel];
    
    //获取验证码
    _checkNumButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-100, 10, 80, 30)];
    [_checkNumButton setTitle:@"获取验证码" forState:0];
    [_checkNumButton addTarget:self action:@selector(_getCheckAction) forControlEvents:UIControlEventTouchUpInside];
    _checkNumButton.layer.cornerRadius = 5;
    _checkNumButton.titleLabel.font = SYSFONT12;
    [_checkNumButton setTitleColor:[UIColor whiteColor] forState:0];
    [_checkNumButton setBackgroundColor:[UIColor redColor]];
    [textView addSubview:_checkNumButton];
    
    //手机号输入
    _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+10, 10, SCREENWIDTH-_checkNumButton.width-phoneLabel.width-40, 30)];
    _phoneText.placeholder = @"请输入手机号";
    [textView addSubview:_phoneText];
    
    //下划线
    //加一个线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH,0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [textView addSubview:lineView];
    
    //验证码
    
    UILabel *checkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineView.bottom+10, 55, 30)];
    checkLabel.text = @"验证码";
    [textView addSubview:checkLabel];
    
    //验证码输入
    _checkText = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+10, checkLabel.top, SCREENWIDTH-checkLabel.width-20, 30)];
    _checkText.placeholder = @"请输入验证码";
    [textView addSubview:_checkText];
    
    
}
/**
 *  获取验证码倒计时
 */
-(void)_getCheckAction{
    //    注册
    NSString *urlString1 = @"getCaptcha.json";
    NSDictionary *parameters1 =  @{
                                  @"mobileNo":_phoneText.text
                                  };
    //讲字典类型转换成json格式的数据，然后讲这个json字符串作为字典参数的value传到服务器
    NSString *jsonStr = [NSDictionary DataTOjsonString:parameters1];
    NSLog(@"jsonStr:%@",jsonStr);
    NSDictionary *params = @{@"json":(NSString *)jsonStr}; //服务器最终接受到的对象，是一个字典，
    
    [JH_NetWorking requestData:urlString1 HTTPMethod:@"GET" params:[params mutableCopy] completionHandle:^(id result) {
        NSDictionary *dic = result;
        NSNumber *isSuccess = dic[@"success"];
        //判断是否成功
        if ([isSuccess isEqual:@1]) {
            /**
             *  关闭进度条
             */
            [SVProgressHUD showSuccessWithStatus:@"数据已加载"];
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            

        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
   
    
    
    //获取验证码同时启动定时器
    _countDown=60;
    //1.关闭点击事件
    _checkNumButton.userInteractionEnabled = NO;
    //2.改变属性
    [_checkNumButton setBackgroundColor:[UIColor clearColor]];
    [_checkNumButton setTitle:[NSString stringWithFormat:@"再次发送(%lis)",_countDown] forState:0];
    
    [_checkNumButton setTitleColor:[UIColor redColor] forState:0];
    //3.启动定时器
    if (_timer==nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(_timerAction) userInfo:nil repeats:YES];
    }
    
    
}
-(void)_timerAction{
    //改变倒计时
    _countDown--;
    //改变文字
    [_checkNumButton setTitle:[NSString stringWithFormat:@"再次发送(%lis)",_countDown] forState:0];
    
    //当倒计时为0销毁定时器，还原button
    if (_countDown==0) {
        [_timer invalidate];
        _timer=nil;
        
        _checkNumButton.userInteractionEnabled = YES;
        [_checkNumButton setTitle:@"获取验证码" forState:0];
        [_checkNumButton setTitleColor:[UIColor whiteColor] forState:0];
        [_checkNumButton setBackgroundColor:[UIColor redColor]];
        
    }
    
    
}
/**
 *  创建电话的布局
 */
-(void)_creatSecondView{
    UIView *aggrementView = [[UIView alloc] initWithFrame:CGRectMake(0, 110+kTopBarHeight, SCREENWIDTH, 50)];
    [self.view addSubview:aggrementView];
    
    //UISwith
    UISwitch *swith = [[UISwitch alloc] initWithFrame:CGRectMake(30, 10, 30, 10)];
    [aggrementView addSubview:swith];
    
    
}
/**
 *  底部的按钮
 */
-(void)_creatBottomView{
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 110+kTopBarHeight+60, SCREENWIDTH-20, 30)];
    
    submitButton.layer.cornerRadius = 5;
    [self.view addSubview:submitButton];
    [submitButton setTitle:@"登录" forState:0];
    [submitButton setBackgroundColor:[UIColor redColor]];
    [submitButton addTarget:self action:@selector(_loginAction) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)_loginAction{
#warning 重新设置程序根视图.未找到其他方法。。。等待优化
    //    登陆
    NSString *urlString1 = @"login.json";
    NSDictionary *parameters1 =  @{
                                   @"mobileNo":_phoneText.text,
                                   @"authCode":_checkText.text
                                   };
    //讲字典类型转换成json格式的数据，然后讲这个json字符串作为字典参数的value传到服务器
    NSString *jsonStr = [NSDictionary DataTOjsonString:parameters1];
    NSLog(@"jsonStr:%@",jsonStr);
    NSDictionary *params = @{@"json":(NSString *)jsonStr}; //服务器最终接受到的对象，是一个字典，
    
    [JH_NetWorking requestData:urlString1 HTTPMethod:@"GET" params:[params mutableCopy] completionHandle:^(id result) {
        NSDictionary *dic = result;
        NSNumber *isSuccess = dic[@"success"];
        //判断是否成功
        if ([isSuccess isEqual:@1]) {
            NSDictionary *data = dic[@"data"];
            //获取用户token
            [[UserInfoSingle sharedInstance] setToken:data[@"token"]];
            //获取userID
             [[UserInfoSingle sharedInstance] setUserId:data[@"userId"]];
            //获取号码
              [[UserInfoSingle sharedInstance] setPhoneNum:data[@"mobileNo"]];

            /**
             *  关闭进度条
             */
            [SVProgressHUD showSuccessWithStatus:@"数据已加载"];
            
            
            //将自身的视图缓慢消失
            [UIView animateWithDuration:0.5 animations:^{
                
                self.view.alpha = 0;
            } completion:^(BOOL finished) {
                
                BaseTabBarVC *tabbar = [[BaseTabBarVC alloc] init];
                AppDelegate *appdelegate = APPDELEGATE;
                appdelegate.window.rootViewController = tabbar;
            }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];

            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];

  

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
