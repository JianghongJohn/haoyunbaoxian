//
//  AddressVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "AddressVC.h"
#import "CitySelectVC.h"
@interface AddressVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *_areaData;
    NSArray *_provinceData;
    NSArray *_cityData;
}
@end

@implementation AddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择省份";
    
    [self _loadAreaData];
    
    [self _creatTableView];
}
/**
 *  加载数据
 */
-(void)_loadAreaData{
   NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];

    _areaData = [NSDictionary dictionaryWithContentsOfFile:stringPath];
    
    _provinceData = [_areaData allKeys];
    
    
}
/**
 *  创建表
 */
-(void)_creatTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _provinceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *ProvinceCell = @"ProvinceCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProvinceCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ProvinceCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = _provinceData[indexPath.row];
    
    return cell;
    
}
#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CitySelectVC *city = [[CitySelectVC alloc]init];
    [self _pushViewController:city];
    //获取城市数据
    NSString *provinceKey = _provinceData[indexPath.row];
    NSArray *cityData = _areaData[provinceKey];
    city.citys = cityData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
