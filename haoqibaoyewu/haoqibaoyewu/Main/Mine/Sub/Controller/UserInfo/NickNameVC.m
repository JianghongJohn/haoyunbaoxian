//
//  NickNameVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "NickNameVC.h"

@interface NickNameVC ()

@end

@implementation NickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    [self _creaTextView];
    [self _creatRightButton];
}
/**
 *  输入框
 */
-(void)_creaTextView{
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(0,kTopBarHeight+10, SCREENWIDTH, 30)];
    [self.view addSubview:textView];
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 0.5;
    textView.placeholder = @"请输入您的昵称";
    
}
/**
 *  完成按钮
 */
-(void)_creatRightButton{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(_rightAction)];
}
/**
 *  完成
 */
-(void)_rightAction{
    NSLog(@"完成");
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
