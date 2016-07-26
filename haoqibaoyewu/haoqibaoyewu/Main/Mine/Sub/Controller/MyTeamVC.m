//
//  MyTeamVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/14.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyTeamVC.h"
#import "JH_RankStarView.h"
#import "TeamMemberVC.h"
@interface MyTeamVC ()

@end

@implementation MyTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的战队";
    [self _craetRantView];
    [self _creatUserHeadImageView];
}
/**
 *  上部视图分为：等级、总保费、总保单 几个线条
 */
-(void)_craetRantView{
    UIView *rankView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+10, SCREENWIDTH, 80)];
    rankView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rankView];
    //等级label
    UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 20)];
    [rankView addSubview:rankLabel];
    rankLabel.textColor = [UIColor redColor];
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.font = SYSFONT14;
    rankLabel.layer.borderColor = [UIColor redColor].CGColor;
    rankLabel.layer.borderWidth = 0.5;
    
    rankLabel.text = @"等级4";
    
    [rankView addSubview:rankLabel];

    //等级星星
    JH_RankStarView *starView = [[JH_RankStarView alloc] initWithFrame:CGRectMake(rankLabel.right+10, rankLabel.top+2, (rankLabel.height-4)*5, rankLabel.height-4) withRank:4];
    [rankView addSubview:starView];
    
    //画条线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,rankLabel.bottom+10, SCREENWIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [rankView addSubview:lineView];
    
    NSArray *labelTitles = @[@"总保费",@"￥520.44",@"总保单",@"5张"];
    //总保费    //总保单
    for (int labelNum=0; labelNum<4; labelNum++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10+SCREENWIDTH/4*labelNum, lineView.bottom+10, SCREENWIDTH/4-10, 20)];
        [rankView addSubview:label];
        label.text = labelTitles[labelNum];
        if (labelNum==1||labelNum==3) {
            label.textColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
        }
        
    }
    //此处还有个分割线
    
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2, lineView.bottom+10, 0.5, 20)];
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [rankView addSubview:verticalLine];

    
}


/**
 *  下部为一个头部标题，人数、头像
 */
-(void)_creatUserHeadImageView{
    UIView *baseHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+10+80+10, SCREENWIDTH, 80)];
    baseHeadView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseHeadView];

    //title
    UILabel *teamMember = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    teamMember.text = @"战队成员";
    [baseHeadView addSubview:teamMember];
    
    //人数
    UIButton *teamNum = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-100,0, 90, 30)];
     [teamNum setImage:[UIImage imageNamed:@"arrow-right"] forState:UIControlStateNormal];
    [teamNum setTitle:@"6人" forState:UIControlStateNormal];
    [teamNum setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
   
    [teamNum setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -100)];
    //点击跳转到成员列表
    [teamNum addTarget:self action:@selector(_PushToMemberView) forControlEvents:UIControlEventTouchUpInside];
    [baseHeadView addSubview:teamNum];
    
    //画条线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,teamMember.bottom, SCREENWIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [baseHeadView addSubview:lineView];
    //头像
    /**
     *  头像使用滚动视图实现，根据成员数量添加
     */
    NSArray *headImages = @[@"",@"",@"",@"",@"",@"",@""];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, lineView.bottom, SCREENWIDTH, 40)];
    scroll.contentSize = CGSizeMake(50*headImages.count, 40);
    [baseHeadView addSubview:scroll];
    for (int imageNum = 0; imageNum<headImages.count; imageNum++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50*imageNum+10, 10, 30, 30)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"3 %i.jpg",(imageNum+2)]];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 15;
        [scroll addSubview:imageView];
    }
    
    
}
/**
 *  点击人数跳转到战队成员页面
 */
-(void)_PushToMemberView{
    TeamMemberVC *teamMember = [[TeamMemberVC alloc] init];
    teamMember.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:teamMember animated:YES];
    
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
