//
//  HomeVC.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/5.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "HomeVC.h"
#import "HomeTableHead.h"
#import "TouchImageView.h"
#import "HomeHotVedioCell.h"
#import "AppDelegate.h"
#import "ActiveListVC.h"
#import "ActiveImageView.h"
#import "NewsWebVC.h"
#import "VedioModel.h"
@interface HomeVC ()<UIActionSheetDelegate>
{
    UITableView *_tableView;

    
    UIScrollView *_scrollView;
    NSArray *_newsData;
    NSMutableArray *_vedioArray;
    
}
@end

@implementation HomeVC
/**
 *  整体为TableView—>HeardView（新闻滚动、四个小菜单、收益展示），单元格分为三组具体结合需求文档。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatLeftButton];
    
    [self _creatRightButton];
    
    [self _loadNewsData];
    
    [self _loadVedioData];
    
    [self _creatTableView];
    
    [self _creatSubView];
}
/**
 *  左侧信息按钮
 */
-(void)_creatLeftButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [button addTarget:self action:@selector(_onLineView) forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:UIIMAGE(@"信息") forState:0];
//添加一个label显示当前搜到的信息量
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 10, 10)];
    label.text = @"1";
    label.font = SYSFONT12;
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    [button addSubview:label];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.navigationItem.leftBarButtonItem = item;
    
    
    
}
-(void)_onLineView{
    
}
/**
 *  右侧客服按钮
 */
-(void)_creatRightButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [button setImage:UIIMAGE(@"客服") forState:0];
    [button addTarget:self action:@selector(_serviceAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.navigationItem.rightBarButtonItem = item;
   
}
/**
 *  客服热线提示
 */
-(void)_serviceAction{
    //打开actionSheet
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"客服工作时间为:9:00-21:00" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"咨询在线客服" otherButtonTitles:@"拨打客服热线", nil];
    [action showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"在线客服");
    }
    if (buttonIndex==1){
        
        NSLog(@"拨打电话");
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        NSURL *urlString = [NSURL URLWithString:@"tel:15757166458"];
        [web loadRequest:[NSURLRequest requestWithURL:urlString]];
        [self.view addSubview:web];
        
    }
    
}
/**
 *  视频数据下载
 */
-(void)_loadVedioData{
    /**
     *  获取数据
     */
    if (_vedioArray==nil) {
        _vedioArray = [NSMutableArray array];
    }
    
    NSString *urlString1 = @"getVideoListByCondition.json";
    NSDictionary *parameters1 =  @{
                                   @"page": @"1",
                                   @"rows": @"3",
                                   @"videoName":@""
                                   };
    //讲字典类型转换成json格式的数据，然后讲这个json字符串作为字典参数的value传到服务器
    NSString *jsonStr = [NSDictionary DataTOjsonString:parameters1];
    NSLog(@"jsonStr:%@",jsonStr);
    NSDictionary *params = @{@"json":(NSString *)jsonStr}; //服务器最终接受到的对象，是一个字典，
    
    [JH_NetWorking requestData:urlString1 HTTPMethod:@"POST" params:[params mutableCopy] completionHandle:^(id result) {
        NSDictionary *dic = result;
        NSNumber *isSuccess = dic[@"success"];
        //判断是否成功
        if ([isSuccess isEqual:@1]) {
            NSArray *data = dic[@"results"];
            for (NSDictionary *dic in data) {
                VedioModel *model = [VedioModel mj_objectWithKeyValues:dic];
                [model setVideoDescription:dic[@"description"]];
                [_vedioArray addObject:model];
            }
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:0];
            /**
             *  关闭进度条
             */
            [SVProgressHUD showSuccessWithStatus:@"数据已加载"];
            
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
}
/**
 *  新闻数据
 */
-(void)_loadNewsData{
    /**
     *  加载新闻数据
     */
    
    NSString *urlString1 = @"getActivityTplListByCondition.json?";
    NSDictionary *parameters1 =
    @{
      @"rows":@3,
      @"type":@"NEWS",
      @"page":@1
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
            
            _newsData = data;
            
//            刷新数据
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            /**
             *  关闭进度条
             */
            [SVProgressHUD dismiss];
            //            [SVProgressHUD showSuccessWithStatus:@"完成"];
            
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];

    
}

/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-kBottomBarHeight-kTopBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //加入头部
    HomeTableHead *tableHead = [[HomeTableHead alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH/2.5+SCREENWIDTH/4+30+60)];
    _tableView.tableHeaderView = tableHead;
    
    
}
-(void)_creatSubView{
    //规定图片大小为宽屏幕1/5长2/5
    CGFloat width = SCREENWIDTH/6;
    /**
     *  将活动展示改成滚动视图
     */
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, width)];
        _scrollView.contentSize = CGSizeMake(SCREENWIDTH/2*5, width);
    }
    /**
     *  加载活动数据
     */
    
    NSString *urlString1 = @"getActivityTplListByCondition.json?";
    NSDictionary *parameters1 =
                                @{
                                  @"rows":@5,
                                  @"type":@"ACTIVITY",
                                  @"page":@1
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
            
            _scrollView.contentSize = CGSizeMake(SCREENWIDTH/2*data.count, width);
            for (int i = 0; i<data.count; i++) {
                NSDictionary *dic = data[i];
                
                ActiveImageView *touchImage = [[ActiveImageView alloc]initWithFrame:CGRectMake(width/4+width*3*i, 10, width*2.5, width)];
                //下载图片
                [touchImage sd_setImageWithURL:[NSURL URLWithString:dic[@"background"]] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
                
                touchImage.avtiveId = dic[@"id"];
                
                
                [_scrollView addSubview:touchImage];
                
            }
            /**
             *  关闭进度条
             */
            [SVProgressHUD dismiss];
//            [SVProgressHUD showSuccessWithStatus:@"完成"];
            
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
    
    
}

#pragma mark - tableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    if (section==2) {
        return _vedioArray.count;
    }
    if (section==1) {
        return _newsData.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //热点培训
    if (indexPath.section==2) {
        HomeHotVedioCell *homeHotVedioCell = [[[NSBundle mainBundle]loadNibNamed:@"HomeHotVedioCell" owner:self options:nil]firstObject];
        homeHotVedioCell.model = _vedioArray[indexPath.row];
        return homeHotVedioCell;
    }else{
        static NSString *homeCell = @"homeCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCell];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:homeCell];
        }
        //热点活动
        if (indexPath.section==0) {
            [cell.contentView addSubview:_scrollView];
            
        }
        //政策资讯
        if (indexPath.section==1) {
            NSDictionary *news = _newsData[indexPath.row];
            
            cell.textLabel.text = news[@"name"];
            cell.textLabel.font = SYSFONT14;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

        
        return cell;
    }
 
    
    
}
#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        return 100;
    }
    if (indexPath.section==0) {
        return SCREENWIDTH/6+20;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
#pragma mark - 分组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     NSArray *headerTitle = @[@"热点活动",@"政策资讯",@"热点培训"];
  
    //一个label 一个button
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    label.textColor = [UIColor redColor];
    label.font = SYSFONT14;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-100, 5, 100, 20)];
   
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setImage:UIIMAGE(@"arrow-right") forState:UIControlStateNormal];
     [button setTitle:@"更多" forState:UIControlStateNormal];
    //左边还有一个图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
    imageView.image = [UIImage imageNamed:@"i"];
    
    
    //设置图片的偏移量
    button.imageEdgeInsets = UIEdgeInsetsMake(0,70,0,0);
    
    button.titleLabel.font = SYSFONT14;
    [view addSubview:label];
    [view addSubview:button];
    [view addSubview:imageView];
    //自定义属性
    label.text = headerTitle[section];
    button.tag = 100+section;
    [button addTarget:self action:@selector(getMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return  view;

}
-(void)getMoreAction:(UIButton *)btn{
    //政策培训跳转教育广场
    NSInteger index = btn.tag;
    if (index==100) {//活动
        ActiveListVC *active = [[ActiveListVC alloc] init];
        [self _pushViewController:active];
        
    }else if (index==101){
        //广场
        //获取tabbar
        AppDelegate *appdelegate = APPDELEGATE;
        UITabBarController *tabbar = (UITabBarController *)appdelegate.window.rootViewController;
        
        tabbar.selectedIndex = 2;
    }else{
        //获取tabbar
        AppDelegate *appdelegate = APPDELEGATE;
        UITabBarController *tabbar = (UITabBarController *)appdelegate.window.rootViewController;
        
        tabbar.selectedIndex = 1;
    }

}
#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        NSDictionary *newsData = _newsData[indexPath.row];
        
        NewsWebVC *news = [[NewsWebVC alloc] init];
        
        news.newsData = newsData;
        news.newsId = newsData[@"id"];
        
        [self _pushViewController:news];
        
   
    }
    
    
}


/**
 *  处理网络数据
 */



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
