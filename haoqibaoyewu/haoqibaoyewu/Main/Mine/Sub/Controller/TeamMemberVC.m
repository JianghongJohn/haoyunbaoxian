//
//  TeamMemberVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/14.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "TeamMemberVC.h"
#import "TeamMemberModel.h"
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

    NSArray *memberData = @[@{@"imageUrl":@"3 2.jpg",
                              @"nickName":@"john啦啦啦",
                              @"realName":@"江红",
                              @"isAlive":@YES
                                },
                            @{@"imageUrl":@"3 2.jpg",
                              @"nickName":@"john啦啦啦",
                              @"realName":@"江红",
                              @"isAlive":@YES
                              },
                            @{@"imageUrl":@"3 2.jpg",
                              @"nickName":@"john啦啦啦",
                              @"realName":@"江红",
                              @"isAlive":@YES
                              },
                            @{@"imageUrl":@"3 2.jpg",
                              @"nickName":@"john啦啦啦",
                              @"realName":@"江红",
                              @"isAlive":@YES
                              },
                            @{@"imageUrl":@"3 2.jpg",
                              @"nickName":@"john啦啦啦",
                              @"realName":@"江红",
                              @"isAlive":@NO
                              },
                            @{@"imageUrl":@"3 2.jpg",
                              @"nickName":@"john啦啦啦",
                              @"realName":@"江红",
                              @"isAlive":@YES
                              },
                            @{@"imageUrl":@"3 2.jpg",
                              @"nickName":@"john啦啦啦",
                              @"realName":@"江红",
                              @"isAlive":@YES
                              }
                            ];
    
    for (NSDictionary *dic in memberData) {
        TeamMemberModel *model = [TeamMemberModel mj_objectWithKeyValues:dic];
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
    return 7;
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
    cell.imageView.image = [self imageCompressWithSimple:[UIImage LoadImageFromBundle:model.imageUrl] scaledToSize:CGSizeMake(45,45)];
    cell.imageView.layer.cornerRadius = 22.5;
    cell.imageView.layer.masksToBounds = YES;
    
    //是否激活
    cell.detailTextLabel.text = model.isAlive?@"":@"未激活";
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    //创建两个标签
    UILabel *nickName = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 150, 30)];
    nickName.text = model.nickName;
    [cell.contentView addSubview:nickName];
    
    UILabel *realName = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 150, 30)];
    realName.text = model.realName;
    realName.textColor = [UIColor grayColor];
    realName.font = SYSFONT14;
    [cell.contentView addSubview:realName];
    
    return cell;
    
}
/**
 *  图片缩放
 *
 *  @param image 传入图片
 *  @param size  需要的图片大小
 *  @return 返回新图片
 */
-(UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
  
    UIImage*newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
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
    MemberInfoVC *memberInfo = [[MemberInfoVC alloc] init];
    memberInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:memberInfo animated:YES];
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
