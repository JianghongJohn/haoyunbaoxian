//
//  EducitonVC.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/5.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "EducationVC.h"
#import "EducationVedioCell.h"
#import "JH_DIYsearchBar.h"
#import "VedioModel.h"
#import "WebViewController.h"


@interface EducationVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *_tableView;
     JH_DIYsearchBar*_searchBar;
    UIButton *_searchButton;
    NSMutableArray *_videoArray;
    NSInteger _page;
    NSString *_videoName;
    
}
@end
/**
 *  4.2：教育
 整体为TableView—>导航栏设置透明，包含搜索按钮；单元格统一样式，点击直接打开视屏播放器（AVPlayer）
 */
@implementation EducationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    _page=1;
    _videoName = @"";
    
   
    [self _creatSearchBar];
    [self _creatTableView];
    /**
     *  判断通知是否执行，执行了则不调用初始方法
     */
    [self _loadDataWithPage:@"1" rows:@"10" byVideoName:@""];
    
    /**
     *  接收通知
     *
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:JH_TurnToVideoById object:nil];
   }
/**
 *  移除通知
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/**
 *  接收通知
 *
 *  @param notification 通知响应方法
 */
-(void)receiveNotification:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo );
    NSDictionary *dic = notification.userInfo;
     _videoArray = [NSMutableArray array];
    
    NSString *urlString1 = @"getVideoListByCondition.json";
    NSDictionary *parameters1 =  @{
                                   @"page": @1,
                                   @"rows": @1,
                                   @"id":dic[@"id"]
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
                    [_videoArray addObject:model];
                
                
                [_tableView reloadData];
            }
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
 *  创建tableView
 */
-(void)_creatTableView{
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchBar.bottom+5, SCREENWIDTH, SCREENHEIGHT-kBottomBarHeight-kTopBarHeight-_searchBar.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    /**
     *  自动刷新
     */
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self _loadDataWithPage:@"1" rows:@"10" byVideoName:_videoName];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self _loadDataWithPage:[NSString stringWithFormat:@"%li",++_page] rows:@"10" byVideoName:_videoName];
    }];
    
}
/**
 *  搜索控件
 */
-(void)_creatSearchBar{
    if (_searchBar==nil) {
        
        _searchBar = [[JH_DIYsearchBar alloc]initWithFrame:CGRectMake(0, kTopBarHeight+5, SCREENWIDTH, 30)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        [self.view addSubview:_searchBar];
    
    }

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;{
    //清空输入文字

    _searchBar.showsCancelButton = YES;
        for (UIView *subview in _searchBar.subviews) {
            if ([subview isKindOfClass:[UIView class]]) {
                for (UIView *nextView in subview.subviews) {
                    /**
                     *  //实验证明此位置在遍历时执行顺序在background后
                     *  @param @"UINavigationButton"
                     *  @return 修改系统控件
                     */
                    if ([nextView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                        _searchButton = (UIButton *)nextView;
                        [_searchButton setTitle:@"取消" forState:0];
                        break;
                    }
                }
            }
        }
}// called when text starts editing

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;   {
    _searchBar.showsCancelButton = NO;
}// called when text ends editing

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;{
    _videoName = searchBar.text;
    //判断文字是否
    if (searchBar.text.length==0) {
        [_searchButton setTitle:@"取消" forState:0];
    }else{
        if (![_searchButton.titleLabel.text isEqualToString:@"搜索"]) {
            
            [_searchButton setTitle:@"搜索" forState:0];
        }
    }
    
}// called when text changes (including clear)

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;  {
 [self _loadDataWithPage:@"1" rows:@"10" byVideoName:_videoName];
}// called when keyboard search button pressed
//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;{
//    
//}// called when bookmark button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; {
    [_searchBar resignFirstResponder];
    if (searchBar.text.length==0) {
        NSLog(@"取消");
    }else{
        NSLog(@"搜索");
        
        [self _loadDataWithPage:@"1" rows:@"10" byVideoName:_videoName];
    }
}// called when cancel
#pragma mark - 加载数据
-(void)_loadDataWithPage:(NSString *)page rows:(NSString *)row byVideoName:(NSString *)videoName{
    /**
     *  获取数据
     */
    if (_videoArray==nil||[page isEqualToString: @"1"]) {
        _videoArray = [NSMutableArray array];
        _page=1;
    }
    
    NSString *urlString1 = @"getVideoListByCondition.json";
    NSDictionary *parameters1 =  @{
                                   @"page": page,
                                   @"rows": row,
                                   @"videoName":videoName
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
            //停止头部刷新
            if (_page==1) {
                [_tableView.mj_header endRefreshing];
            }else{
                [_tableView.mj_footer endRefreshing];
            }
            if (data.count==0) {//停止尾部刷新
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                
                for (NSDictionary *dic in data) {
                    VedioModel *model = [VedioModel mj_objectWithKeyValues:dic];
                    [model setVideoDescription:dic[@"description"]];
                    [_videoArray addObject:model];
                }
              
                
                [_tableView reloadData];
            }
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




#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _videoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    EducationVedioCell *educationVedioCell = [[[NSBundle mainBundle]loadNibNamed:@"EducationVedioCell" owner:self options:nil]firstObject];
    educationVedioCell.model = _videoArray[indexPath.row];
    return educationVedioCell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取视频链接
    VedioModel *model = _videoArray[indexPath.row];
   
    WebViewController *web = [[WebViewController alloc] init];
    
    web.urlString = model.videoUrl;
#warning 此处存在一定的内存泄漏**********WARNING:  WARNING:  40: ERROR: couldn't get default input device, ID = 0, err = 0! *********803: The default input device 0x0 '(null)' has no input channels.
    
    [self _pushViewController:web];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
