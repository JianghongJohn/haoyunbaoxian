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
@interface InviterListVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *_tableView;
    JH_DIYsearchBar*_searchBar;
    UIButton *_searchButton;
}

@end

@implementation InviterListVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索邀请人";
    
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
    
    searchBar.text = nil;
    
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
    //判断文字是否
    if (searchBar.text.length==0) {
        [_searchButton setTitle:@"取消" forState:0];
    }else{
        if (![_searchButton.titleLabel.text isEqualToString:@"搜索"]) {
            
            [_searchButton setTitle:@"搜索" forState:0];
        }
    }
    
}// called when text changes (including clear)

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;  {
//
//}// called when keyboard search button pressed
//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;{
//
//}// called when bookmark button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; {
    [_searchBar resignFirstResponder];
    if (searchBar.text.length==0) {
        NSLog(@"取消");
    }else{
        NSLog(@"搜索");
    }
}// called when cancel




#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    InviterListCell *inviterListCell = [[[NSBundle mainBundle]loadNibNamed:@"InviterListCell" owner:self options:nil]firstObject];
    return inviterListCell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InviterVC *inviter = [[InviterVC alloc] init];
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
