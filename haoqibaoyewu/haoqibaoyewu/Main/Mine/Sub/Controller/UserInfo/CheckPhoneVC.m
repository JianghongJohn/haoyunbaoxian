//
//  CheckPhoneVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/19.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "CheckPhoneVC.h"

@interface CheckPhoneVC ()
{
    UIButton *_checkNumButton;
    NSTimer *_timer;
    NSInteger _countDown;
}
@end

@implementation CheckPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证信息";
    
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
    UITextField *phoneText = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+10, 10, SCREENWIDTH-_checkNumButton.width-phoneLabel.width-40, 30)];
    phoneText.placeholder = @"请输入手机号";
    [textView addSubview:phoneText];

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
    UITextField *checkText = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+10, checkLabel.top, SCREENWIDTH-checkLabel.width-20, 30)];
    checkText.placeholder = @"请输入验证码";
    [textView addSubview:checkText];
    
  
    
}
/**
 *  获取验证码倒计时
 */
-(void)_getCheckAction{
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
   UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 110+kTopBarHeight, SCREENWIDTH, 50)];
    [self.view addSubview:phoneView];
    //两个带文字图片的button
    UIButton *phoneCall = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH/2, 30)];
    [phoneView addSubview:phoneCall];
    [phoneCall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phoneCall setTitle:@"客服热线" forState:UIControlStateNormal];
    [phoneCall setImage:UIIMAGE(@"客服热线") forState:UIControlStateNormal];
    
    UIButton *onlinePhoneCall = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2, 10, SCREENWIDTH/2, 30)];
    [phoneView addSubview:onlinePhoneCall];
    [onlinePhoneCall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onlinePhoneCall setTitle:@"在线客服" forState:UIControlStateNormal];
    [onlinePhoneCall setImage:UIIMAGE(@"在线客服") forState:UIControlStateNormal];
    
    
    //加一个线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2, 5, 0.5, 40)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [phoneView addSubview:lineView];
    
}
/**
 *  底部的按钮
 */
-(void)_creatBottomView{
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 110+kTopBarHeight+60, SCREENWIDTH-20, 30)];
    
    submitButton.layer.cornerRadius = 5;
    [self.view addSubview:submitButton];
    [submitButton setTitle:@"提交" forState:0];
    [submitButton setBackgroundColor:[UIColor redColor]];
    
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
