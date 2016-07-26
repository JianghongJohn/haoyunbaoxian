//
//  InviterVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "InviterVC.h"

@interface InviterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_detailNames;//详细信息
    NSArray *_titleNames;//名称
}
@end

@implementation InviterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请人";
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
    /**
     *  创建一个底部按钮
     *
     *  @return 点击推出登陆
     */
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];
    
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, SCREENWIDTH-40, 30)];
    bottomButton.backgroundColor = [UIColor redColor];
    [bottomButton setTitle:@"加入" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomButton.layer.cornerRadius = 5;
    [bottomView addSubview:bottomButton];
    
    _tableView.tableFooterView = bottomView;
}
//创建内部的一些视图

/**
 *  处理数据
 */
-(void)_makeData{
    _detailNames = @[@"追梦赤子",@"江红",@"15757166458",@"1",@"￥520.00"];
    _titleNames = @[@"",@"真实姓名",@"手机号",@"总保费",@"总保单"];

}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *inviterCell = @"inviterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inviterCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:inviterCell];
    }
    
    cell.textLabel.text = _titleNames[indexPath.row];
    cell.detailTextLabel.text = _detailNames[indexPath.row];
    //添加头像
    if (indexPath.row==0) {
        
        cell.imageView.image = [UIImage imageCompressWithSimple:[UIImage LoadImageFromBundle:@"20 4.jpg"] scaledToSize:CGSizeMake(50, 50)];
        //未实现缩放
//         cell.imageView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        cell.imageView.layer.cornerRadius = 25;
        cell.imageView.layer.masksToBounds = YES;

    }
    
    return cell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 60;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
