//
//  NewsWebVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/25.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "NewsWebVC.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface NewsWebVC ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
{
    UIView *_headView;
    UIWebView *_webView;
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
    NSURL *_url;
}
@end

@implementation NewsWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广场详情";
   
//    

    [self _loadNewsHtml];
    
    [self _creatHeadView];
    
    [self _creatForwardBackButton];
  
}
/**
 *  创建底部的网页前进和返回的按钮
 */
-(void)_creatForwardBackButton{
    CGFloat bottomHeight = 35;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-bottomHeight, SCREENWIDTH, bottomHeight)];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.9];
    
    //前进按钮
    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(bottomHeight, 0, bottomHeight, bottomHeight)];
    [bottomView addSubview:forwardButton];
    [forwardButton setImage:UIIMAGE(@"arrow-right") forState:0];
    [forwardButton addTarget:self action:@selector(forwardAction) forControlEvents:UIControlEventTouchUpInside];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]  initWithFrame:CGRectMake(0, 0, bottomHeight, bottomHeight)];
    [bottomView addSubview:backButton];
    [backButton setImage:UIIMAGE(@"指向（左）") forState:0];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
}
/**
 *  前进
 */
-(void)forwardAction{
    [_webView goForward];
}
/**
 *  返回
 */
-(void)backAction{
    if (_tpl &&![_webView canGoBack]) {
        [_webView loadHTMLString:_tpl baseURL:nil];
        return;
    }
    [_webView goBack];
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
        _webView.delegate = self;
        [self.view insertSubview:_webView atIndex:1];
    
        [_webView loadHTMLString:_tpl baseURL:nil];
    }
    
}
/**
 *  加载点击的ruquest
 *
 *  @param request 打开的链接
 */
-(void)loadRequest:(NSURLRequest *)request{
    /**
     webviewProgress
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _webViewProgress = [[NJKWebViewProgress alloc] init];
        _webView.delegate = _webViewProgress;
        _webViewProgress.webViewProxyDelegate = self;
        _webViewProgress.progressDelegate = self;
        
        CGRect navBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0,
                                     navBounds.size.height - 2,
                                     navBounds.size.width,
                                     2);
        _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_webViewProgressView setProgress:0 animated:YES];
        [self.navigationController.navigationBar addSubview:_webViewProgressView];
    });
    
    
    
    [_webView loadRequest:request];
    
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    //    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    switch (navigationType)
    {
            //点击连接
        case UIWebViewNavigationTypeBackForward:
        {
            NSLog(@"back");
        }
            break;
            //提交表单
        case UIWebViewNavigationTypeLinkClicked:
        {
            NSLog(@"link");
            [self loadRequest:request];
        }
        case UIWebViewNavigationTypeFormSubmitted:
        {
            NSLog(@"submit");
        }
        case UIWebViewNavigationTypeReload:
        {
            NSLog(@"reload");
        }
        case UIWebViewNavigationTypeFormResubmitted:
        {
            NSLog(@"resubmit");
        }
        case UIWebViewNavigationTypeOther:
        {
            NSLog(@"other");
        }
        default:
            break;
    }
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar addSubview:_webViewProgressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_webViewProgressView removeFromSuperview];
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
