//
//  NewsWebVC.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/25.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "BaseVC.h"

@interface NewsWebVC : BaseVC
@property(nonatomic,copy)NSString *tpl;
//@property(nonatomic,copy)NSString *webTitle;
@property(nonatomic,copy)NSDictionary *newsData;
@property(nonatomic,copy)NSString *newsId;

@end
