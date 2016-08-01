//
//  TeamMemberVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/14.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "TeamMemberVC.h"

#import "MemberInfoVC.h"

@interface TeamMemberVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_memberArray;
}
@end

@implementation TeamMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"战队成员";
    [self _makeData];
    [self _creatTableView];
}
/**
 *  数据处理*
 */
-(void)_makeData{
    if (_memberArray==nil) {
        _memberArray = [NSMutableArray array];
    }
    
    for (NSDictionary *dic in _memberList) {
        TeamMemberModel *model = [TeamMemberModel mj_objectWithKeyValues:dic ];
        [_memberArray addObject:model];
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
    return _memberList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *teamMemberCell = @"teamMemberCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:teamMemberCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:teamMemberCell];
    }
    //箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TeamMemberModel *model = _memberArray[indexPath.row];
    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
   
    [headImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:JH_BaseImage]];
    [cell.contentView addSubview:headImageView];
    headImageView.layer.cornerRadius = 25;
    headImageView.layer.masksToBounds = YES;
    
    
    //是否激活
    cell.detailTextLabel.text = model.state?@"":@"未激活";
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    //创建两个标签
    UILabel *nickName = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 150, 30)];
    nickName.text = model.nickName;
    [cell.contentView addSubview:nickName];
    
    UILabel *realName = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 150, 30)];
    realName.text = model.name;
    realName.textColor = [UIColor grayColor];
    realName.font = SYSFONT14;
    [cell.contentView addSubview:realName];
    
    return cell;
    
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
#pragma mark - 选中事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_memberList.count!=0) {
        TeamMemberModel *model = _memberArray[indexPath.row];
        
        MemberInfoVC *memberInfo = [[MemberInfoVC alloc] init];
        memberInfo.memberModel = model;
        
        memberInfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:memberInfo animated:YES];
    }
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
