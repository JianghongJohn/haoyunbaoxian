//
//  HomeTableHead.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/7.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "HomeTableHead.h"
#import "ActiveImageView.h"
#import "MyWalletVC.h"
#import "MyTaskVC.h"

@implementation HomeTableHead
{
    UIScrollView *_scrollView;
    UIPageControl *_pagerControl;
    NSInteger _totalNum;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _creatScrollView];
       
        [self _creatManuButton];
        
        [self _creatProfitView];
    }
    return self;
}
#pragma mark - 滚动视图
//滚动视图
-(void)_creatScrollView{
    if (_scrollView==nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH/2.5)];
        [self addSubview:_scrollView];
        //滚动图属性（暂定四页）
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        /**
         *  获取数据
         */
        //    登陆
        NSString *urlString1 = @"getBannerList.json";
        NSDictionary *parameters1 =  @{
                                       @"name": @"",
                                       @"page": @"1",
                                       @"rows": @"10",

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
                NSInteger totalNum = data.count;
                _totalNum = totalNum;
                /**
                 *  创建
                 */
                 [self _creatPageControl];
                
                 _scrollView.contentSize = CGSizeMake(_scrollView.width*totalNum, _scrollView.height);
                for (int i = 0; i<totalNum; i++) {
                    NSDictionary *dic = data[i];
                    
                    ActiveImageView *touchImage = [[ActiveImageView alloc]initWithFrame:CGRectMake(i*SCREENWIDTH, 0, _scrollView.width, _scrollView.height)];
                    //下载图片
                    [touchImage sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
                    NSLog(@"%@",dic[@"activityTplId"]);
                    touchImage.avtiveId = dic[@"activityTplId"];

                    
                    [_scrollView addSubview:touchImage];
                    
                }
                
                /**
                 *  关闭进度条
                 */
                [SVProgressHUD dismiss];
//                [SVProgressHUD showSuccessWithStatus:@"完成"];
                
                
                
            }else{
                [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
                
                
            }
            
            
        } errorHandle:^(NSError *error) {
            
        }];
        
        //创建完毕滚动视图即可开始自动
        [self _StartTimer];
    }
    
}
//pagercontrol
-(void)_creatPageControl{
    if (_pagerControl==nil) {
        
        _pagerControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-50, _scrollView.height-30, 100, 20)];
        [self addSubview:_pagerControl];
        _pagerControl.numberOfPages = _totalNum;
        
        _pagerControl.currentPage = 0;
    }
    
}
//滚动联动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获得偏移量
    CGFloat offset = scrollView.contentOffset.x;
    //利用余数获取当前页数
    _pagerControl.currentPage = offset/SCREENWIDTH;

}
//自动轮播视图
-(void)_StartTimer{
    //启动定时器
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}
//自动滚动
-(void)autoScroll{
    //分为两类
    //最后一页
    if (_pagerControl.currentPage==_totalNum-1) {
        _pagerControl.currentPage = 0;
//        _scrollView.contentOffset = CGPointMake(SCREENWIDTH*_pagerControl.currentPage, 0);
    }else{
        //其他
        _pagerControl.currentPage++;
       
        
    }
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREENWIDTH*_pagerControl.currentPage, 0);
    }];
  
    
}

//四个小菜单
-(void)_creatManuButton{
        //限定按钮大小
    //限定为30大小的文本
    
    CGFloat textHeight = 21;
    CGFloat btnWidth = SCREENWIDTH/4*3/4;
    CGFloat btnSpace = btnWidth/3/2;
    
    UIView *manuView = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.bottom, SCREENWIDTH, SCREENWIDTH/4+textHeight)];
    manuView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    [self addSubview:manuView];
    //按钮图片来源
    NSArray *imageNames = @[@"make-offer",@"wallet",@"task",@"helper"];
    NSArray *labelNames = @[@"报价",@"钱包",@"任务",@"助手"];
    
    for (int i = 0; i<4; i++) {
        //创建按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnSpace+SCREENWIDTH/4*i, 10, btnWidth, btnWidth)];
        [manuView addSubview:button];
        [button setImage:UIIMAGE(imageNames[i]) forState:UIControlStateNormal];
        button.tag = 100+i;
        [button addTarget:self action:@selector(manuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        //创建标签
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btnSpace+SCREENWIDTH/4*i, button.bottom, btnWidth, textHeight)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.text = labelNames[i];
        label.font = SYSFONT16;
        label.textAlignment = NSTextAlignmentCenter;
        [manuView addSubview:label];
        
    }
}
//菜单按钮的响应事件
-(void)manuButtonAction:(UIButton *)btn{
    NSInteger index = btn.tag-100;
    //说明：点击钱包进入我的钱包
    //点击任务:进入我的任务
    //助手进入体验站
    if (index==0) {
    
    }else if (index==1){
        MyWalletVC *wallet = [[MyWalletVC alloc] init];
        wallet.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:wallet animated:YES];
    }else if (index==2){
        MyTaskVC *task = [[MyTaskVC alloc] init];
        task.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController: task animated:YES];
    }else{
        
    
    }
    
}


//收益
-(void)_creatProfitView{
    UIView *profitView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENWIDTH/2.5+SCREENWIDTH/4+30, SCREENWIDTH, 60)];
    profitView.backgroundColor = [UIColor whiteColor];
    [self addSubview:profitView];
    //此处有三个标签一个图片
    /**
     使用换行符和富文本将五个标签进行优化成3个
     */
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, profitView.width, profitView.height)];
    bgImageView.image = [UIImage LoadImageFromBundle:@"bj2.png"];
    [profitView addSubview:bgImageView];
    CGFloat hammerImageHeight = 40;
    
    UIImageView *hammerImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-hammerImageHeight-10,10, hammerImageHeight+5, hammerImageHeight)];
    hammerImage.image = [UIImage imageNamed:@"hammer"];
    [profitView addSubview:hammerImage];
    
//标签靠右以右侧图片为基准
//    本月收益
    CGFloat width = SCREENWIDTH-hammerImageHeight-20;
    UILabel *thisMonthProfit = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, width/3, hammerImageHeight)];
    thisMonthProfit.font = SYSFONT13;
    thisMonthProfit.textColor = [UIColor grayColor];
    thisMonthProfit.numberOfLines = 2;
    thisMonthProfit.textAlignment = NSTextAlignmentCenter;
   
    [profitView addSubview:thisMonthProfit];
    
//    累计收益
    UILabel *totalProfit = [[UILabel alloc] initWithFrame:CGRectMake(width/3, 10, width/3, hammerImageHeight)];
    totalProfit.font = SYSFONT13;
    totalProfit.numberOfLines = 2;
    totalProfit.textAlignment = NSTextAlignmentCenter;
    totalProfit.textColor = [UIColor grayColor];
    [profitView addSubview:totalProfit];
    
//    描述
    UILabel *subscribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/3*2, 10, width/3, hammerImageHeight)];
    subscribeLabel.font = SYSFONT13;
    subscribeLabel.numberOfLines = 2;
    subscribeLabel.textAlignment = NSTextAlignmentCenter;
    subscribeLabel.textColor = [UIColor grayColor];
    [profitView addSubview:subscribeLabel];
    
//***********************************************
    /**
     *  获取数据
     */
    
    NSString *urlString1 = @"income.json";
    NSDictionary *parameters1 =  @{
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
            
            NSString *currentMonth = data[@"currentMonth"];
            NSString *accumulation = data[@"accumulation"];
            NSString *beatPercent = data[@"beatPercent"];
            
            //    富文本设置
            NSString *thisMonth = currentMonth;
            thisMonth = [NSString stringWithFormat:@"本月收益\n%@",thisMonth];
            //富文本对象
            NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:thisMonth];
            //富文本样式
            [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                                      value:[UIColor redColor]
                                      range:NSMakeRange(4, thisMonth.length-4)];
            
            [aAttributedString addAttribute:NSFontAttributeName             //文字字体
                                      value:[UIFont systemFontOfSize:17]
                                      range:NSMakeRange(4, thisMonth.length-4)];
            
            thisMonthProfit.attributedText = aAttributedString;
            //***********************************************
            
            NSString *total = accumulation;
            total = [NSString stringWithFormat:@"累计收益\n%@",total];
            
            //富文本对象
            NSMutableAttributedString * aAttributedString1 = [[NSMutableAttributedString alloc] initWithString:total];
            //富文本样式
            [aAttributedString1 addAttribute:NSForegroundColorAttributeName  //文字颜色
                                       value:[UIColor redColor]
                                       range:NSMakeRange(4, total.length-4)];
            
            [aAttributedString1 addAttribute:NSFontAttributeName             //文字字体
                                       value:[UIFont systemFontOfSize:17]
                                       range:NSMakeRange(4, total.length-4)];
            
            totalProfit.attributedText = aAttributedString1;
            //***********************************************
            NSString *subscribe = [NSString stringWithFormat:@"%@,的同行!",beatPercent];
            subscribe = [NSString stringWithFormat:@"您已经击败了\n%@",subscribe];
            
            
            //    //富文本对象
            NSMutableAttributedString * aAttributedString2 = [[NSMutableAttributedString alloc] initWithString:subscribe];
            //富文本样式
            [aAttributedString2 addAttribute:NSForegroundColorAttributeName  //文字颜色
                                       value:[UIColor redColor]
                                       range:NSMakeRange(6, subscribe.length-4-6)];
            
            
            subscribeLabel.attributedText = aAttributedString2;
            /**
             *  关闭进度条
             */
            [SVProgressHUD dismiss];
            
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
    

    
    /**
     *  为了界面效果添加一个分割线
     */
    UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0, profitView.height-5, SCREENWIDTH, 5)];
    [profitView addSubview:separateView];
    separateView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    
}



@end
