//
//  ActiveImageView.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/25.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "ActiveImageView.h"

@implementation ActiveImageView
{
    NSString *_webtitle;
    NSString *_webtpl;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = YES;
      
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (!(_avtiveId==nil)) {
        
        WebViewController *web = [[WebViewController alloc] init];
       
        web.webTitle = _webtitle;
        web.tpl = _webtpl;
        
        web.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:web animated:YES];
    }else{
        [SVProgressHUD showWithStatus:@"数据错误"];
        [SVProgressHUD dismissWithDelay:1];
    }
    
}
-(void)setAvtiveId:(NSString *)activeId{
    if (_avtiveId!=activeId) {
        _avtiveId=activeId;
          [self _loadData];
    }
}
/**
 *  加载数据
 */
-(void)_loadData{
    /**
     *  获取数据
     */
    
    NSString *urlString1 = @"getActivityTpl.json";
    NSDictionary *parameters1 =  @{
                                   @"id": _avtiveId,
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
                
                //获取name
                _webtitle = data[@"name"];
                //获取tpl
                _webtpl = data[@"tpl"];
                
                [SVProgressHUD dismiss];
                
                
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
}


@end
