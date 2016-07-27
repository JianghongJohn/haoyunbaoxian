//
//  NickNameVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "NickNameVC.h"

@interface NickNameVC ()
{
    UITextField *_textView;
}
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
    _textView = [[UITextField alloc] initWithFrame:CGRectMake(0,kTopBarHeight+10, SCREENWIDTH, 30)];
    [self.view addSubview:_textView];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.placeholder = @"请输入您的昵称";
    _textView.text = self.nickname;
    
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
    /**
     *  获取数据
     */
    
    NSString *urlString1 = @"updateUserInfo.json";
    NSDictionary *parameters1 =  @{
                                   @"nickName":_textView.text
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
           
            self.nicknameBlock(_textView.text);
            /**
             *  关闭进度条
             */
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            
            
            
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
