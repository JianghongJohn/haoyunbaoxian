//
//  SquareVC.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/5.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "SquareVC.h"
#import "SquareCell.h"
@interface SquareVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *_headImageView;
}

@end
/**
 *  整体为TableView—>头视图下拉放大，点击进入WebView；单元格统一样式（存在热门标志），点击打开WebView。
 */
@implementation SquareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    if (_headImageView==nil) {
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH/2.5f)];
        
    }
    _headImageView.image = [UIImage LoadImageFromBundle:@"information.jpg"];
    _tableView.tableHeaderView = _headImageView;
    
}



#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    SquareCell *squareCell = [[[NSBundle mainBundle]loadNibNamed:@"SquareCell" owner:self options:nil]firstObject];
    return squareCell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
