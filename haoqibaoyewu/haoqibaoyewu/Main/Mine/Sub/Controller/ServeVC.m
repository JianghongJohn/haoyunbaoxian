//
//  ServeVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/15.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "ServeVC.h"
#import "ServeCell.h"
#import "ServeModel.h"
@interface ServeVC()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_insuranceData;
}
@end

@implementation ServeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"理赔服务";
    [self _makeData];
    [self _creatTableView];
}


/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStyleGrouped];
    }
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
}
//创建内部的一些视图

/**
 *  处理数据
 */
-(void)_makeData{
    if (_insuranceData==nil) {
        _insuranceData = [NSMutableArray array];
    }
    NSArray *data = @[@{@"insuranceId":@"ZGRB",@"imageName":@"人保",@"title":@"中国人保",@"phoneNum":@"95518"},
                      
                          @{@"insuranceId":@"YGWX",@"imageName":@"阳光网销",@"title":@"阳光网销",@"phoneNum":@"95533"},
                      
                          @{@"insuranceId":@"ASTP",@"imageName":@"安盛天平",@"title":@"安盛天平",@"phoneNum":@"95599"},
                      
                          @{@"insuranceId":@"TACX",@"imageName":@"天安财险",@"title":@"天安财险",@"phoneNum":@"95588"},
                      
                          @{@"insuranceId":@"YACX",@"imageName":@"永安财险",@"title":@"永安财险",@"phoneNum":@"95555"},
                      
                          @{@"insuranceId":@"ZHLH",@"imageName":@"中华联合",@"title":@"中华联合",@"phoneNum":@"95585"},
                      
                          @{@"insuranceId":@"TPYBX",@"imageName":@"太平洋保险",@"title":@"太平洋保险",@"phoneNum":@"95500"}
                          ];
    for (NSDictionary *insurance in data) {
        ServeModel *model = [ServeModel mj_objectWithKeyValues:insurance];
        [_insuranceData addObject:model];
    }
    
    
    
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ServeCell *serveCell = [[[NSBundle mainBundle]loadNibNamed:@"ServeCell" owner:self options:nil]firstObject];

    serveCell.model = _insuranceData[indexPath.row];
    
    return serveCell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
