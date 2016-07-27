//
//  NSString+JH_CityName_Code_Change.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/27.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "NSString+JH_CityName_Code_Change.h"

@implementation NSString (JH_CityName_Code_Change)
//+(NSString *)ChangeNameToCode{
//    
//}
+(NSString *)CodeNameToName:(NSString *)code{
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"citycode" ofType:@"json"];
    //根据文件路径读取数据
    NSData *jdata = [[NSData alloc]initWithContentsOfFile:stringPath];
    NSError*error;
    //格式化成json数据
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
    
    NSArray *province = jsonObject;
    NSString *provinceName;
    
    NSString *twoSting = [code substringToIndex:2];
    NSArray *cities;
    //匹配省份，获取城市
    for (NSDictionary *dic in province) {
        if ([dic[@"province_code"]hasPrefix:twoSting]) {
            //找到前两个代码匹配，则获取城市数组，结束循环
            cities = dic[@"cities"];
            provinceName = dic[@"province"];
            break;
        }
    }
    NSString *city;
    //匹配城市
    for (NSDictionary *dic in cities) {
        if ([code isEqualToString:dic[@"city_code"]]) {
            city = dic[@"city"];
        }
    }
    if (city==nil) {
      return [NSString stringWithFormat:@"%@",provinceName];  
    }
    return [NSString stringWithFormat:@"%@ %@",provinceName,city];
}
@end
