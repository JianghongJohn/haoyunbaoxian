//
//  SquareVC.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/5.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "SquareVC.h"
#import "SquareModel.h"
#import "SquareCell.h"
#import "NewsWebVC.h"
@interface SquareVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *_headImageView;
    NSMutableArray *_newsData;
    NSInteger _page;
}

@end
/**
 *  整体为TableView—>头视图下拉放大，点击进入WebView；单元格统一样式（存在热门标志），点击打开WebView。
 */
@implementation SquareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    
    [self _loadDataWithPage:@"1"];
    
    [self _creatTableView];
}
/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-kBottomBarHeight-kTopBarHeight) style:UITableViewStylePlain];
    }
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //头部视图
//    if (_headImageView==nil) {
//        
//        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH/2.5f)];
//        
//    }
//    _headImageView.image = [UIImage LoadImageFromBundle:@"information.jpg"];
//    _tableView.tableHeaderView = _headImageView;
    
    /**
     *  自动刷新
     */
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self _loadDataWithPage:@"1"];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self _loadDataWithPage:[NSString stringWithFormat:@"%li",++_page]];
    }];
}

#pragma mark - 下载数据
-(void)_loadDataWithPage:(NSString *)page{
    /**
     *  加载新闻数据
     */
    if (_newsData==nil||[page isEqualToString:@"1"]) {
        _newsData = [NSMutableArray array];
    }
    NSString *urlString1 = @"getActivityTplListByCondition.json?";
    NSDictionary *parameters1 =
    @{
      @"rows":@10,
      @"type":@"NEWS",
      @"page":page
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
            if (_page==1) {
                [_tableView.mj_header endRefreshing];
            }else{
                [_tableView.mj_footer endRefreshing];
            }
            if (data.count!=0) {
                
                for (NSDictionary *news in data) {
                    SquareModel *model = [SquareModel mj_objectWithKeyValues:news];
                    model.newsDescription = news[@"description"];
                    
                    [_newsData addObject:model];
                }
                
                [_tableView reloadData];
            }else{
                [_tableView.mj_footer endRefreshingWithNoMoreData];
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
    return _newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    SquareCell *squareCell = [[[NSBundle mainBundle]loadNibNamed:@"SquareCell" owner:self options:nil]firstObject];
    
    squareCell.model = _newsData[indexPath.row];
    
    return squareCell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SquareModel *model = _newsData[indexPath.row];
    NewsWebVC *news = [[NewsWebVC alloc] init];
    news.newsId = [NSString stringWithFormat:@"%li",model.id];
    news.newsData = @{
                      @"name":model.name,
                      @"media":model.media,
                      @"displayTime":@(model.displayTime)
                      };
    [self _pushViewController:news];
    
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
