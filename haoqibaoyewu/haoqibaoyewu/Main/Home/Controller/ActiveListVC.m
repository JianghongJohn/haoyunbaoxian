//
//  ActiveListVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/21.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "ActiveListVC.h"
#import "ActiveCell.h"
#import "WebViewController.h"
@interface ActiveListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
}


@end

@implementation ActiveListVC

/**
 活动列表
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";
    [self _loadData];
    [self _creatTableView];
}
/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}
-(void)_loadData{
    /**
     *  加载活动数据
     */
    
    NSString *urlString1 = @"getActivityTplListByCondition.json?";
    NSDictionary *parameters1 =
    @{
      @"rows":@10,
      @"type":@"ACTIVITY",
      @"page":@1
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
            NSArray *data = dic[@"results"];
            
            _dataArray = data;
            
            //刷新数据
            [_tableView reloadData];
            /**
             *  关闭进度条
             */
            [SVProgressHUD dismiss];
            
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
}


#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ActiveCell *activeCell = [[[NSBundle mainBundle]loadNibNamed:@"ActiveCell" owner:self options:nil]firstObject];
    NSDictionary *active = _dataArray[indexPath.row];
    activeCell.imageUrl = active[@"background"];
    
    return activeCell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREENWIDTH/2.5;
}
#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *active = _dataArray[indexPath.row];
    
    /**
     *  获取数据
     */
    
    NSString *urlString1 = @"getActivityTpl.json";
    NSDictionary *parameters1 =  @{
                                   @"id": active[@"id"],
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
            NSDictionary *data = dic[@"results"];
            //判断data数据是否为空
            if ([data isKindOfClass:[NSNull class]]) {
                [SVProgressHUD showErrorWithStatus:@"无数据"];
            }else{

                
                WebViewController *web = [[WebViewController alloc] init];
          
                    web.webTitle = data[@"name"];
                    web.tpl = data[@"tpl"];
                    
//                    web.hidesBottomBarWhenPushed = YES;
                
                    [self _pushViewController:web];
      
                [SVProgressHUD dismiss];
            }
            
            
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
