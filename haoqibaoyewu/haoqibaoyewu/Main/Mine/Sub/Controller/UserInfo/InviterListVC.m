//
//  InviterListVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/21.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "InviterListVC.h"
#import "JH_DIYsearchBar.h"
#import "InviterListCell.h"
#import "InviterVC.h"
#import "InviterModel.h"
@interface InviterListVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *_tableView;
    JH_DIYsearchBar*_searchBar;
    UIButton *_searchButton;
    NSMutableArray *_inviterArray;
    
    NSInteger _page;
    NSString *_inviterName;
}

@end

@implementation InviterListVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索邀请人";
    _page = 1;
    _inviterName = @"";
    
    [self _loadDataWithPage:@"1" WithRows:@"10" ByKey:_inviterName];
    
    [self _creatSearchBar];
    
    [self _creatTableView];
}
/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchBar.bottom+5, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight-_searchBar.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self _loadDataWithPage:@"1" WithRows:@"10" ByKey:_inviterName];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [self _loadDataWithPage:[NSString stringWithFormat:@"%li",++_page] WithRows:@"10" ByKey:_inviterName];
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
    _inviterName = searchBar.text;
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
    [self _loadDataWithPage:@"1" WithRows:@"10" ByKey:_inviterName];

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
        
        [self _loadDataWithPage:@"1" WithRows:@"10" ByKey:_inviterName];
    }
}// called when cancel
#pragma mark - 邀请人搜索
-(void)_loadDataWithPage:(NSString *)page WithRows:(NSString *)rows ByKey:(NSString *)key{
    /**
     *  获取数据
     */
    if (_inviterArray==nil||[page isEqualToString:@"1"]) {
        _page = 1;
        _inviterArray = [NSMutableArray array];
        
    }
    
    NSString *urlString1 = @"getUserList.json";
    NSDictionary *parameters1 =  @{
                                   @"nameOrMobile": key,
                                   @"page": page,
                                   @"rows": rows
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
            //停止头部刷新
            if (_page==1) {
                [_tableView.mj_header endRefreshing];
            }else{
                  [_tableView.mj_footer endRefreshing];
            }
            NSDictionary *data = dic[@"data"];
            NSArray *results = data[@"results"];
            if (results.count!=0) {
                
                for (NSDictionary *dic in results) {
                    InviterModel *model = [InviterModel mj_objectWithKeyValues:dic];
                    
                    [_inviterArray addObject:model];
                    //刷新数据
                    [_tableView reloadData];
                }
              
            }else{
                
                [_tableView.mj_footer endRefreshingWithNoMoreData];
                
            }
            /**
             *  关闭进度条
             */
            [SVProgressHUD dismiss];
   
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
    
}



#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _inviterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    InviterListCell *inviterListCell = [[[NSBundle mainBundle]loadNibNamed:@"InviterListCell" owner:self options:nil]firstObject];
    inviterListCell.model = _inviterArray[indexPath.row];
    return inviterListCell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InviterModel *model = _inviterArray[indexPath.row];
    
    InviterVC *inviter = [[InviterVC alloc] init];
    
    inviter.model = model;
    
    [self _pushViewController:inviter];
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
