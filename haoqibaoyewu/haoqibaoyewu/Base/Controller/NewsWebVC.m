//
//  NewsWebVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/25.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "NewsWebVC.h"

@interface NewsWebVC ()
{
    UIView *_headView;
    UIWebView *_webView;
}
@end

@implementation NewsWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广场详情";
   
//    

    [self _loadNewsHtml];
    
    [self _creatHeadView];

  
}

/**
 *  创建头部的视图
 */
-(void)_creatHeadView{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, 60)];
  
    
    /**
     *  标题
     
     *  来源
     
     *  时间
     
     *  热门
     
     */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH, 30)];
    titleLabel.text = _newsData[@"name"];
    [_headView addSubview:titleLabel];
    
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 30)];
    sourceLabel.font = SYSFONT12;
    sourceLabel.text = _newsData[@"media"];
    [_headView addSubview:sourceLabel];

    UILabel *creatLabel = [[UILabel alloc] initWithFrame:CGRectMake(sourceLabel.right, 30, 100, 30)];
    creatLabel.font = SYSFONT12;

    NSString *timeData = [self changeTimeIntervalToDate:_newsData[@"displayTime"]];
    creatLabel.text = timeData;
    
    [_headView addSubview:creatLabel];
    
    
    UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-60, 35,45, 20)];
    hotLabel.backgroundColor = [UIColor whiteColor];
    hotLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    hotLabel.layer.borderWidth = 0.5;
    hotLabel.textColor = [UIColor redColor];
    hotLabel.textAlignment = NSTextAlignmentCenter;
    hotLabel.font = SYSFONT14;
    hotLabel.text = @"热门";
    [_headView addSubview:hotLabel];
    
      [self.view addSubview:_headView];
}
/**
 *  改变时间戳
 *
 *  @return 固定格式的时间
 */
-(NSString *)changeTimeIntervalToDate:(NSNumber *)timeInterval{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]/1000]];
    
    //输出格式为：2010-10-27
    return currentDateStr;
}
/**
 *  加载新闻数据
 */
-(void)_loadNewsHtml{
    /**
     *  获取数据
     */
    
    NSString *urlString1 = @"getActivityTpl.json";
    NSDictionary *parameters1 =  @{
                                   @"id": _newsId,
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
                [SVProgressHUD showErrorWithStatus:@"服务器错误"];
            }else{
                
                
                _tpl = data[@"tpl"];
                

                [self _creatWebView];
                
                [SVProgressHUD dismiss];
                
                
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
    
}
/**
 *  创建webview
 */
-(void)_creatWebView{
    
    if (_webView==nil) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+60, SCREENWIDTH, SCREENHEIGHT-kBottomBarHeight-60)];
        _webView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_webView];
    
        [_webView loadHTMLString:_tpl baseURL:nil];
    }
    
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
