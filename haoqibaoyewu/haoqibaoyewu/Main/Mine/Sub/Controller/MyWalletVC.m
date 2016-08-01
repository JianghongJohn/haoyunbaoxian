//
//  MyWalletVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/13.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyWalletVC.h"
#import "BonusView.h"
@interface MyWalletVC ()
{
    
    BonusView *_todayBonus;
    BonusView *_totalBonus;
    BonusView *_remainBonus;
    BonusView *_usefulBonus;
    
    
}
@end

@implementation MyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    [self _creatViews];
    [self _creatButton];
    [self _creatRightView];
    
    [self _loadUserBankInfo];
}
-(void)_loadUserBankInfo{
    NSString *urlString1 = @"getUserAccount.json";
    NSDictionary *parameters1 =  @{
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
            
            NSDictionary *userKpi = data[@"userKpi"];
            if (userKpi[@"todayBonus"]==nil) {
            }else{
                _todayBonus.nonusNum = [NSString stringWithFormat:@"%@",userKpi[@"todayBonus"]];
            }
            if ([userKpi[@"totalBonus"]isKindOfClass:[NSNull class]]) {
            }else{
                _totalBonus.nonusNum = [NSString stringWithFormat:@"%@",userKpi[@"totalBonus"]];
                
            }
            if ([userKpi[@"remainBonus"]isKindOfClass:[NSNull class]]) {
                
            }else{
                 _remainBonus.nonusNum = [NSString stringWithFormat:@"%@",userKpi[@"remainBonus"]];
            }
            if ([userKpi[@"remainBonus"]isKindOfClass:[NSNull class]]) {
                
            }else{
                 _usefulBonus.nonusNum = [NSString stringWithFormat:@"%@",userKpi[@"remainBonus"]];
            }
            
            
            
            /**
             *  关闭进度条
             */
            [SVProgressHUD dismiss];
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];}


/**
 *  奖金部分视图-->封装一个view上下两个label组合
 */
-(void)_creatViews{
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+10, SCREENWIDTH, 150)];
    [self.view addSubview:baseView];
    baseView.backgroundColor = [UIColor whiteColor];
    
    //今日奖金
    _todayBonus = [[BonusView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-80, 20, 160, 60) withTitle:@"今日奖金" withBonusNum:@"0.00" withFont:SYSFONT17];
    _todayBonus.bonusColor = [UIColor redColor];
    [baseView addSubview:_todayBonus];
    /**添加下划线
     */
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _todayBonus.bottom+10, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [baseView addSubview:lineView];
    
    //累计奖金
    _totalBonus = [[BonusView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3*0, _todayBonus.bottom+20, SCREENWIDTH/3, 40) withTitle:@"累计奖金" withBonusNum:@"0.00" withFont:SYSFONT14];
    _totalBonus.bonusColor = [UIColor redColor];
    [baseView addSubview:_totalBonus];
    //未提奖金
    _remainBonus = [[BonusView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3*1, _todayBonus.bottom+20, SCREENWIDTH/3, 40) withTitle:@"未提奖金" withBonusNum:@"0.00" withFont:SYSFONT14];
    _remainBonus.bonusColor = [UIColor redColor];
    [baseView addSubview:_remainBonus];
    //可提奖金
    _usefulBonus = [[BonusView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3*2, _todayBonus.bottom+20, SCREENWIDTH/3, 40) withTitle:@"可提奖金" withBonusNum:@"0.00" withFont:SYSFONT14];
    _usefulBonus.bonusColor = [UIColor redColor];
    [baseView addSubview:_usefulBonus];
    
}
/**
 *  下部的两个按钮
 */
-(void)_creatButton{
    //申请提现
    UIButton *cashButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 170+kTopBarHeight, SCREENWIDTH-40, 30)];
    cashButton.backgroundColor = [UIColor redColor];
    [cashButton setTitle:@"申请提现" forState:UIControlStateNormal];
    [cashButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cashButton.layer.cornerRadius = 15;
    [self.view addSubview:cashButton];
    
    //奖金明细
    UIButton *bonusButton =[[UIButton alloc] initWithFrame:CGRectMake(20, cashButton.bottom+20, SCREENWIDTH-40, 30)];
    bonusButton.backgroundColor = [UIColor whiteColor];
    
    [bonusButton setTitle:@"奖金明细" forState:UIControlStateNormal];
     bonusButton.layer.cornerRadius = 15;
    [bonusButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.view addSubview:bonusButton];
    
}
/**
 *  右上角按钮-->提现记录
 */
-(void)_creatRightView{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
    
}
-(void)rightAction{
    NSLog(@"提现记录");
    
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
