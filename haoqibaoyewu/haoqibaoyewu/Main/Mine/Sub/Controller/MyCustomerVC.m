//
//  MyCustomerVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyCustomerVC.h"
#import "MyCustomerCell.h"
#import "CustomerDetailVC.h"
#import "JH_DIYsearchBar.h"
#import "MyCustomerModel.h"
#import "UnPaidCustomerCell.h"
#import "UnPaidCustomerVC.h"
@interface MyCustomerVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *_tableView;
    UIView *_headerView;
    UIImageView *_bottomLineView;
     JH_DIYsearchBar*_searchBar;
    UIButton *_searchButton;
    NSMutableArray *_customerArray;
    NSInteger _page;
    NSString *_customerName;
    NSString *_api;
}

@end

@implementation MyCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的客户";
    //初始化
    _page=1;
    _customerName = @"";
    _api = @"myPaidCustomer.json";
    
    [self _creatSearchBar];
    [self _craetHeaderView];
    [self _creatTableView];
    
    [self _loadDataForPage:@"1" rows:@"10" byCustomerName:_customerName];
}
/**
 *  创建两个个分类的头视图
 */
-(void)_craetHeaderView{
    if (_headerView==nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREENWIDTH, 40)];
        _headerView.backgroundColor = [UIColor whiteColor];
        NSArray *titles = @[@"成单客户",@"意向客户"];
        for (int buttonIndex; buttonIndex<titles.count; buttonIndex++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2*buttonIndex, 0, SCREENWIDTH/2, 40)];
            button.tag = 100+buttonIndex;
            [button setTitle:titles[buttonIndex] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            if (buttonIndex==0) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            [_headerView addSubview:button];
        }
        _bottomLineView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2/2/2, 38, SCREENWIDTH/2/2, 2)];
        _bottomLineView.backgroundColor = [UIColor redColor];
        [_headerView addSubview:_bottomLineView];
    }
    //添加一些辅助线
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.height-0.5, SCREENWIDTH, 0.5)];
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:verticalLine];
    
    //添加一些辅助线
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2, 5, 0.5, 30)];
    horizontalLine.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:horizontalLine];
    
    
}
/**
 *  按钮点击事件
 *
 *  @return 点击切换按钮颜色以及底部标志
 */
-(void)_buttonAction:(UIButton *)btn{
    //遍历子视图
    for (UIView *view in _headerView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (view.tag==btn.tag) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
    }
    //移动底部标记
    [UIView animateWithDuration:0.5 animations:^{
        _bottomLineView.center = CGPointMake(btn.center.x, 38);
    }];
    switch (btn.tag) {
        case 100:
            _api = @"myPaidCustomer.json";
             [self _loadDataForPage:@"1" rows:@"10" byCustomerName:_customerName];
            break;
        case 101:
            _api = @"myUnPaidCustomer.json";
             [self _loadDataForPage:@"1" rows:@"10" byCustomerName:_customerName];
            break;
        default:
            break;
    }
}



/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  _searchBar.bottom+5, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStylePlain];
    }
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    /**
     *  自动刷新
     */
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self _loadDataForPage:@"1" rows:@"10" byCustomerName:_customerName];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self _loadDataForPage:[NSString stringWithFormat:@"%li",++_page] rows:@"10" byCustomerName:_customerName];
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
    _customerName = searchBar.text;
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
    [self _loadDataForPage:@"1" rows:@"10" byCustomerName:_customerName];
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
        
        [self _loadDataForPage:@"1" rows:@"10" byCustomerName:_customerName];
    }
}// called when cancel
#pragma mark - 加载数据
-(void)_loadDataForPage:(NSString *)page rows:(NSString *)row byCustomerName:(NSString *)customerName{
    /**
     *  获取数据
     */
    if (_customerArray==nil||[page isEqualToString: @"1"]) {
        _customerArray = [NSMutableArray array];
        _page=1;
    }
    
    NSString *urlString1 = _api;
    NSDictionary *parameters1 =  @{
                                   @"page": page,
                                   @"rows": row,
                                   @"nameOrVehicle":customerName
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
            NSDictionary *datas = dic[@"data"];
            NSArray *data = datas[@"results"];
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
                    MyCustomerModel *model = [MyCustomerModel mj_objectWithKeyValues:dic];
                    
                    [_customerArray addObject:model];
                }
                
                
            }
            [_tableView reloadData];
            /**
             *  关闭进度条
             */
            [SVProgressHUD showSuccessWithStatus:@"数据已加载"];
            
            
            
        }else{
            [_tableView reloadData];

            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            
        }
        
        
    } errorHandle:^(NSError *error) {
        [_tableView reloadData];

        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    }];
    
}
#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _customerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([_api isEqualToString:@"myPaidCustomer.json"]) {
        
        MyCustomerCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyCustomerCell" owner:self options:nil]firstObject];
        cell.model = _customerArray[indexPath.row];
        return cell;
    }else{
        UnPaidCustomerCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"UnPaidCustomerCell" owner:self options:nil]firstObject];
        cell.model = _customerArray[indexPath.row];
        return cell;
    }
    
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCustomerModel *model = _customerArray[indexPath.row];
    NSInteger customerId = model.customerId;
    NSInteger vehicleId = model.vehicleId;
    NSString *license = model.licensePlateNumber;

    if ([_api isEqualToString:@"myPaidCustomer.json"]) {
        
        CustomerDetailVC *customerDetail = [[CustomerDetailVC alloc] init];
        customerDetail.customerId = [NSString stringWithFormat:@"%li",customerId];
        customerDetail.vehicleId = [NSString stringWithFormat:@"%li",vehicleId];
        customerDetail.licensePlateNumber = license;
        
        [self _pushViewController:customerDetail];
    }else{
        UnPaidCustomerVC *unPaidcustomerDetail = [[UnPaidCustomerVC alloc] init];
        
        unPaidcustomerDetail.customerId = [NSString stringWithFormat:@"%li",customerId];
        unPaidcustomerDetail.vehicleId = [NSString stringWithFormat:@"%li",vehicleId];
        unPaidcustomerDetail.licensePlateNumber = license;
        
        [self _pushViewController:unPaidcustomerDetail];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
