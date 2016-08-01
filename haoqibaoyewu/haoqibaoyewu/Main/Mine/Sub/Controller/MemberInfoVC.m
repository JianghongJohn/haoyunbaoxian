//
//  MemberInfoVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/15.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MemberInfoVC.h"

@interface MemberInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_detailNames;//详细信息
    NSArray *_titleNames;//名称
}
@end

@implementation MemberInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成员信息";
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
    //判断数据是否为空
    NSString *name;
    NSString *nickName;
    
    if (_memberModel.name ==nil) {
        name = @"";
    }else{
        name = _memberModel.name;
    }
    if (_memberModel.nickName == nil) {
        nickName = @"";
    }else{
        nickName = _memberModel.nickName;
    }
  
    
    _detailNames = @[nickName,name,@(_memberModel.policyCount),@(_memberModel.premium),@(_memberModel.todayPolicyCount),@(_memberModel.todayPremium)];
    _titleNames = @[@"",@"真实姓名",@"总保单数",@"总保费",@"当日保单数",@"总保费数"];
    
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _detailNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *inviterCell = @"inviterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inviterCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:inviterCell];
    }
    
    cell.textLabel.text = _titleNames[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_detailNames[indexPath.row] ];
    //添加头像
    if (indexPath.row==0) {
        
        //头像
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        
        [headImageView sd_setImageWithURL:[NSURL URLWithString:_memberModel.headUrl] placeholderImage:[UIImage imageNamed:JH_BaseImage]];
        [cell.contentView addSubview:headImageView];
        headImageView.layer.cornerRadius = 25;
        headImageView.layer.masksToBounds = YES;
        
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
