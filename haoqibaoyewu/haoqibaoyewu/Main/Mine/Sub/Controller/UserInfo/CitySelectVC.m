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
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
