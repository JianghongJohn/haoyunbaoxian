//
//  MineVC.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/5.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MineVC.h"
#import "MineWalletCell.h"
#import "UserInfoVC.h"
#import "OrderVC.h"
#import "MyTaskVC.h"
#import "MyTeamVC.h"
#import "ServeVC.h"
#import "QuestionAnswerVC.h"
#import "MyCustomerVC.h"
#import "ShareVC.h"
#import "UserInfoModel.h"
@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    NSDictionary *_userInfo;//用户信息
    NSDictionary *_userAccount;//账户信息
    //会变化的属性
    NSArray *_imageNames;//使用的图标
    NSArray *_titleNames;//名称
    UIImageView *_headImage;//用户头像
    UILabel *_nameLabel;//用户名字
  
}


@end
/**
 *  整体为TableView—>单元格分四组（用户信息、财产、个人业务、额外服务）
 */
@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _makeData];
  
    
    [self _creatSubViews];
    [self _creatTableView];
}
-(void)viewWillAppear:(BOOL)animated{
#warning 此处存在两个任务同时刷新tableView的操作，需要做线程等待
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"A");
//         [self _loadMyData];
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"B");
//            [self _loadUserAccount];
//    });
    //加载网络数据
    
   [self _loadUserAccount];
    
    [self _loadMyData];
}

/**
 *  创建tableView
 */
-(void)_creatTableView{
    
    if (_tableView==nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-kBottomBarHeight-kTopBarHeight) style:UITableViewStyleGrouped];
    }
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;



}
//创建内部的一些视图
-(void)_creatSubViews{
    //用户信息考虑到会发生变化故做成全局的
    if (_headImage==nil) {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
        _headImage.layer.cornerRadius = _headImage.width/2;
        _headImage.layer.masksToBounds = YES;
        _headImage.image = [UIImage LoadImageFromBundle:@"20 4.jpg"];
    }
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 150, 40)];
        _nameLabel.text = @"江小红";
    }
    
}
/**
 *  处理数据
 */
-(void)_makeData{
    _imageNames = @[@"订单",@"客户",@"战队",@"任务",@"有奖",@"咨询",@"体验站",@"理赔",@"更多"];
    _titleNames = @[@"我的订单",@"我的客户",@"我的战队",@"我的任务",@"推荐有奖",@"问题咨询",@"体验站",@"理赔服务",@"更多"];
    
}
#pragma mark - 我的数据信息
-(void)_loadMyData{
    /**
     *  获取数据
     "data": {
     "userId": 59,
     "headUrl": "http://bcis.oss-cn-hzfinance.aliyuncs.com/data/1468999866053.jpg?Expires=1784359861&OSSAccessKeyId=pAOuT63dTHx9GiUd&Signature=/mVSRqOQnmSDwc10iU6izQtenvg%3D",
     "nickName": "小红",
     "cityCode": "310100",
     "inviterId": 98,
     "inviterName": "羊羊羊",
     "state": "00",
     "mobileNo": "15757166458",
     "rejectReason": null,
     "openId": "oZwSdwb3oxqpYT0tPSmyoYGWpf6g"
     }
     */
    
    NSString *urlString1 = @"getUserInfo.json";
    NSDictionary *parameters1 =  @{
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
            NSDictionary *data = dic[@"data"];
            _userInfo = data;
            
            //刷新UI
            [_headImage sd_setImageWithURL:[NSURL URLWithString:data[@"headUrl"]] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
            //判断数据是否为空
            if (![data[@"nickName"] isKindOfClass:[NSNull class]]) {
                
                _nameLabel.text = data[@"nickName"];
            }else{
                _nameLabel.text = @"";
            }
            
            
            /**
             *  关闭进度条
             */
            [SVProgressHUD dismiss];
//           [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
////
//            [_tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
    
}
-(void)_loadUserAccount{
    
    /**
     *  获取数据"data": {
     "userKpi": {
     "kpiId": 26,
     "userId": 59,
     "totalBonus": 0.00,
     "remainBonus": 0.00,
     "premium": 0.00,
     "policyCount": 0,
     "todayPremium": 0.00,
     "todayPolicyCount": 0,
     "bonusPoint": 0.00,
     "todayBonus": 0.00,
     "todayPolicyTime": 1469518470000,
     "todayBonusTime": 1469518470000,
     "monthBonus": 0.00,
     "monthBonusTime": 1469030400000,
     "createTime": 1468569396000,
     "updateTime": 1469518470000,
     "monthPremium": null
     },
     "account": {
     "accountId": 52,
     "userId": 59,
     "accountNo": null,
     "amount": 0.00,
     "availAmt": 0.00,
     "frozenAmt": 0.00,
     "accountType": "01",
     "status": "01",
     "createTime": 1468569396000,
     "updateTime": 1468569396000
     },
     "cityCode": null,
     "premium": null,
     "policyCount": null,
     "totalBonusAmount": null,
     "userId": null,
     "totalBonus": null,
     "name": null,
     "mobileNo": null,
     "personCount": null,
     "teamPremium": null,
     "teamPolicyCount": null,
     "teamTotalBonus": null
     }
     */
    
    NSString *urlString1 = @"getUserAccount.json";
    NSDictionary *parameters1 =  @{
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
            NSDictionary *data = dic[@"data"];
            _userAccount = data;

            /**
             *  关闭进度条
             */
            [SVProgressHUD dismiss];
            
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
//            [_tableView reloadData];
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
    
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section==0||section==1) {
        return 1;
    }
    if (section==3) {
        return 5;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
//    设置向右标签
    //创建第一组
    if (indexPath.section==0) {
        static NSString *headCell = @"headCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:headCell];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        [cell.contentView addSubview:_headImage];
        [cell.contentView addSubview:_nameLabel];
        return cell;
    }else if (indexPath.section!=1) {
        static NSString *mineCell = @"mineCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineCell];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mineCell];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //第三组和第四组
    if (indexPath.section==2) {
        cell.imageView.image = UIIMAGE(_imageNames[indexPath.row]);
        
        cell.textLabel.text = _titleNames[indexPath.row];
    }
    if (indexPath.section==3) {
        cell.imageView.image = UIIMAGE(_imageNames[indexPath.row+4]);
        
        NSLog(@"%@",_titleNames[indexPath.row+4]);
        cell.textLabel.text = _titleNames[indexPath.row+4];
    }
        
        return cell;
}else{
        MineWalletCell *walletCell  = [[[NSBundle mainBundle]loadNibNamed:@"MineWalletCell" owner:self options:nil]firstObject];
    
    if (_userAccount!=nil) {
        NSDictionary *userAccount = _userAccount[@"account"];
        NSNumber *amount = userAccount[@"amount"];
        walletCell.walletAmount = [NSString stringWithFormat:@"%@",amount];
        
        NSDictionary *userKpi = _userAccount[@"userKpi"];
        NSNumber *bonusPoint = userKpi[@"bonusPoint"];
        walletCell.pointAmount = [NSString stringWithFormat:@"%@",bonusPoint];
        
        
    }
        return walletCell;
    }
    
   
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0||indexPath.section==1) {
        return 100;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  用户信息
     */
    if (indexPath.section==0) {
        UserInfoVC *user = [[UserInfoVC alloc] init];
        
        UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:_userInfo];
        user.userModel = model;
        
        [self _pushViewController:user];
       
    }

    /**
     *  我的订单
     *
     */
    if (indexPath.section==2&&indexPath.row==0) {
        OrderVC *order = [[OrderVC alloc] init];
        
        [self _pushViewController:order];
    }
    /**
     *  我的任务
     *
     */
    if (indexPath.section==2&&indexPath.row==3) {
        MyTaskVC *task = [[MyTaskVC alloc] init];
        
        [self _pushViewController:task];
    }
    /**
     *  我的战队
     *
     */
    if (indexPath.section==2&&indexPath.row==2) {
        MyTeamVC *team = [[MyTeamVC alloc] init];
        
        [self _pushViewController:team];
        
        
    }
    /**
     *  理赔服务
     *
     */
    if (indexPath.section==3&&indexPath.row==3) {
        ServeVC *serve = [[ServeVC alloc] init];
        
        [self _pushViewController:serve];
    }
    /**
     *  问题咨询
     */
    if (indexPath.section==3&&indexPath.row==1) {
        QuestionAnswerVC *QAVC = [[QuestionAnswerVC alloc] init];
    
        [self _pushViewController:QAVC];
    }
    /**
     我的客户
     */
    if (indexPath.section==2&&indexPath.row==1) {
        
        MyCustomerVC *customer = [[MyCustomerVC alloc] init];
 
        [self _pushViewController:customer];
    }
    /**
     分享好友
     */
    if (indexPath.section==3&&indexPath.row==0) {
        
        ShareVC *share = [[ShareVC alloc] init];
        
        [self _pushViewController:share];
    }
    
    
}
/**
 *  push动作封装
 */

-(void)_pushViewController:(UIViewController *)controller{
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
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
