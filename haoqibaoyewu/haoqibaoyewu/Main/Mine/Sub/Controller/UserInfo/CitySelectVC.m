//
//  CitySelectVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "CitySelectVC.h"

@interface CitySelectVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CitySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    [self _creatTableView];
}
-(void)_creatTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.citys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cityCell = @"CityCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cityCell];
    }
    cell.textLabel.text = self.citys[indexPath.row];
    
    return cell;
    
}
#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        //获取城市数据
    NSString *cityKey = self.citys[indexPath.row];
    NSLog(@"选择城市:%@",cityKey);
    NSString *citycode = self.city_codes[indexPath.row];
    NSLog(@"选择城市:%@",citycode);
    /**
     *  获取数据
     */
    
    NSString *urlString1 = @"updateUserInfo.json";
    NSDictionary *parameters1 =  @{
                                   @"cityCode":citycode
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
            //发送通知给
            [[NSNotificationCenter defaultCenter]postNotificationName:JH_UserCityChange object:nil userInfo:@{@"city_code":citycode}];
            
            //pop到我的资料页面
           UIViewController *VC = [self.navigationController.viewControllers objectAtIndex:1];
            
            [self.navigationController popToViewController:VC animated:YES];
            
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
