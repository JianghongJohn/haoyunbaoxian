//
//  WebViewController.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/7.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "WebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface WebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    UIWebView *_webView;
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _webTitle;

    
    [self _creatWebView];

    [self _creatForwardBackButton];
}
/**
 *  创建webview
 */
-(void)_creatWebView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kBottomBarHeight)];
//    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    
#pragma mark - 只有启动urlRequest才使用进度条
    if (![self.urlString isKindOfClass:[NSNull class]]&&self.urlString!=nil&&![self.urlString isEqualToString:@""]) {
        /**
         webviewProgress
         */
        
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
        
        NSURL *url = [NSURL URLWithString:_urlString];
        NSURLRequest *reuqest = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:reuqest];
        
    }
    /**
     *  如果是含有html源码，将直接加载html源码
     */
    if (![self.tpl isKindOfClass:[NSNull class]]&&self.tpl!=nil) {
        
        _webView.delegate = self;
        [_webView loadHTMLString:_tpl baseURL:nil];
  
    }
}
/**
 *  创建底部的网页前进和返回的按钮
 */
-(void)_creatForwardBackButton{
    CGFloat bottomHeight = 35;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-bottomHeight, SCREENHEIGHT, bottomHeight)];
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
