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
    NSArray *_areaData;
    NSMutableArray *_provinceData;
    NSMutableArray *_cityData;
    
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
   NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"citycode" ofType:@"json"];
    //根据文件路径读取数据
    NSData *jdata = [[NSData alloc]initWithContentsOfFile:stringPath];
     NSError*error;
    //格式化成json数据
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
    
    _areaData = jsonObject;
    
    _provinceData  = [NSMutableArray array];
    
    for (NSDictionary *data in _areaData) {
        NSString *province = data[@"province"];
        [_provinceData addObject:province];
    }
    
//    _provinceData = [_areaData allKeys];
    
    
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
    NSDictionary *province = _areaData[indexPath.row];
    NSString *provinceName = province[@"province"];
    //城市
    NSArray *citys = province[@"cities"];
    //城市名称
    NSMutableArray *allCitys = [NSMutableArray array];
    //城市编码
    NSMutableArray *city_code = [NSMutableArray array];
    
    for (NSDictionary *dic in citys) {
        NSString *thisCity = dic[@"city"];
        NSString *citycode = dic[@"city_code"];
        
        [allCitys addObject:thisCity];
        [city_code addObject:citycode];
    }
    
    city.citys = allCitys;
    city.city_codes = city_code;
    city.provinceName = provinceName;
    
    
//    city.citys = cityData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
