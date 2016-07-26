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

@end

@implementation MyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    [self _creatViews];
    [self _creatButton];
    [self _creatRightView];
}
/**
 *  奖金部分视图-->封装一个view上下两个label组合
 */
-(void)_creatViews{
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+10, SCREENWIDTH, 150)];
    [self.view addSubview:baseView];
    baseView.backgroundColor = [UIColor whiteColor];
    
    //今日奖金
    BonusView *todayBonus = [[BonusView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-80, 20, 160, 60) withTitle:@"今日奖金" withBonusNum:@"5.20" withFont:SYSFONT17];
    todayBonus.bonusColor = [UIColor redColor];
    [baseView addSubview:todayBonus];
    /**添加下划线
     */
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, todayBonus.bottom+10, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [baseView addSubview:lineView];
    
    //累计奖金
    BonusView *totalBonus = [[BonusView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3*0, todayBonus.bottom+20, SCREENWIDTH/3, 40) withTitle:@"累计奖金" withBonusNum:@"5.20" withFont:SYSFONT14];
    totalBonus.bonusColor = [UIColor redColor];
    [baseView addSubview:totalBonus];
    //未提奖金
    BonusView *noneBonus = [[BonusView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3*1, todayBonus.bottom+20, SCREENWIDTH/3, 40) withTitle:@"未提奖金" withBonusNum:@"5.20" withFont:SYSFONT14];
    noneBonus.bonusColor = [UIColor redColor];
    [baseView addSubview:noneBonus];
    //可提奖金
    BonusView *usefulBonus = [[BonusView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3*2, todayBonus.bottom+20, SCREENWIDTH/3, 40) withTitle:@"可提奖金" withBonusNum:@"5.20" withFont:SYSFONT14];
    usefulBonus.bonusColor = [UIColor redColor];
    [baseView addSubview:usefulBonus];
    
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
