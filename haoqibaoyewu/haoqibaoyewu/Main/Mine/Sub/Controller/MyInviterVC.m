//
//  MyInviter.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyInviterVC.h"
#import "InviterListVC.h"
@interface MyInviterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_detailNames;//详细信息
    NSArray *_titleNames;//名称
}

@end

@implementation MyInviterVC

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
    [bottomButton setTitle:@"更改邀请人" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(_changeInviter) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.layer.cornerRadius = 5;
    [bottomView addSubview:bottomButton];
    
    _tableView.tableFooterView = bottomView;
}
/**
 *  修改邀请人
 */
-(void)_changeInviter{
    InviterListVC *inviterList = [[InviterListVC alloc] init];
    [self _pushViewController:inviterList];
    
}
//创建内部的一些视图

/**
 *  处理数据
 */
-(void)_makeData{
    /**
     *  获取数据
     */
    
    NSString *urlString1 = @"getMyInviter.json";
    NSDictionary *parameters1 =  @{
                                   @"inviterId": @(_inviterId)
                                   
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
            /**
             *  关闭进度条
             */
            //获取数据
            if ([data isKindOfClass:[NSNull class]]) {
                _detailNames = @[@"",@"",@"",@"",@""];
            }else{
                
                _detailNames = @[data[@"name"],data[@"mobileNo"],data[@"personCount"],data[@"premium"],data[@"policyCount"]];
                
               
            }
             [_tableView reloadData];
            [SVProgressHUD dismiss];
    
        }else{
            _detailNames = @[@"",@"",@"",@"",@""];
            
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
//    _detailNames = @[@"江红",@"15757166458",@"20",@"￥520.00",@"4"];
    _titleNames = @[@"姓名",@"电话",@"人数",@"总保费",@"总保单"];
    
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _detailNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *myInviterCell = @"myInviterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myInviterCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myInviterCell];
    }
    
        cell.textLabel.text = _titleNames[indexPath.row];
    if ([_detailNames[indexPath.row] isKindOfClass:[NSNumber class]]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_detailNames[indexPath.row]];
    }else{
        
        cell.detailTextLabel.text = _detailNames[indexPath.row];
    }
    
    return cell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark - 选中事件



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
