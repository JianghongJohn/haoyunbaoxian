//
//  InviterVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "InviterVC.h"

@interface InviterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_detailNames;//详细信息
    NSArray *_titleNames;//名称
}
@end

@implementation InviterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请人";
    [self _makeData];
    [self _creatTableView];
}


/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStyleGrouped];
    }
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    /**
     *  创建一个底部按钮
     *
     *  @return 点击推出登陆
     */
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];
    
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, SCREENWIDTH-40, 30)];
    bottomButton.backgroundColor = [UIColor redColor];
    [bottomButton setTitle:@"加入" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(_joinAction) forControlEvents:UIControlEventTouchUpInside];
    
    bottomButton.layer.cornerRadius = 5;
    [bottomView addSubview:bottomButton];
    
    _tableView.tableFooterView = bottomView;
}
-(void)_joinAction{
    /**
     *  获取数据
     */
    
    NSString *urlString1 = @"updateInviter.json";
    NSDictionary *parameters1 =  @{
                                   @"inviterId": @(_model.userId),
                                   @"inviterName": _model.name,
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
            
            //发送通知
            //发送通知给
            [[NSNotificationCenter defaultCenter]postNotificationName:JH_UserCityChange object:nil userInfo:@{@"inviteName":_model.name,@"inviteId":@(_model.userId)}];
            /**
             *  关闭进度条
             */
            [SVProgressHUD showSuccessWithStatus:@"加入成功"];
            UIViewController *VC = [self.navigationController.viewControllers objectAtIndex:1];
            
            [self.navigationController popToViewController:VC animated:YES];
       
      
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
}


//创建内部的一些视图

/**
 *  处理数据
 */
-(void)_makeData{
    //数据验证
    if (_model.nickName==nil) {
        _model.nickName = @"";
    }
    if (_model.name==nil) {
        _model.name = @"";
    }
    if (_model.mobileNo==nil) {
        _model.mobileNo = @"";
    }
    if (_model.premium==nil) {
        _model.premium = @"0";
    }
    
    
    _detailNames = @[_model.nickName,_model.name,_model.mobileNo,_model.premium,[NSString stringWithFormat:@"%li",_model.policyCount]];
    _titleNames = @[@"",@"真实姓名",@"手机号",@"总保费",@"总保单"];

}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *inviterCell = @"inviterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inviterCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:inviterCell];
    }
    
    cell.textLabel.text = _titleNames[indexPath.row];
    cell.detailTextLabel.text = _detailNames[indexPath.row];
    //添加头像
    if (indexPath.row==0) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_model.headUrl] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
        
        //未实现缩放
//         cell.imageView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        imageView.layer.cornerRadius = 25;
        imageView.layer.masksToBounds = YES;
        
        [cell.contentView addSubview:imageView];
    }
    
    return cell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 60;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
