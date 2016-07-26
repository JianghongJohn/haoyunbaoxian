//
//  OrderVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "OrderVC.h"
#import "MyOrderCell.h"
@interface OrderVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView *_headerView;
    UIImageView *_bottomLineView;
}
@end
/**
 *  形式采用同一单元格，分类为全部；代付款；已完成
 */
@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    [self _craetHeaderView];
    [self _creatTableView];

}
/**
 *  创建三个分类的头视图
 */
-(void)_craetHeaderView{
    if (_headerView==nil) {
           _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        _headerView.backgroundColor = [UIColor whiteColor];
        NSArray *titles = @[@"全部",@"待付款",@"已完成"];
        for (int buttonIndex; buttonIndex<titles.count; buttonIndex++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/3*buttonIndex, 0, SCREENWIDTH/3, 40)];
            button.tag = 100+buttonIndex;
            [button setTitle:titles[buttonIndex] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            if (buttonIndex==0) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            [_headerView addSubview:button];
        }
         _bottomLineView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3/2/2, 38, SCREENWIDTH/3/2, 2)];
        _bottomLineView.backgroundColor = [UIColor redColor];
        [_headerView addSubview:_bottomLineView];
    }
    
    
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
            
            break;
        case 101:
            
            break;
        case 102:
            
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
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStylePlain];
    }
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MyOrderCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyOrderCell" owner:self options:nil]firstObject];
    
    return cell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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
