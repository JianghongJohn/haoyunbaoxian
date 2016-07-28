//
//  UserInfoVCViewController.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "UserInfoVC.h"
#import "AuthenticationVC.h"
#import "MyInviterVC.h"
#import "InviterVC.h"
#import "MyHeadPortrait.h"
#import "NickNameVC.h"
#import "AddressVC.h"
#import "CheckPhoneVC.h"
#import "NSString+JH_CityName_Code_Change.h"
#import "LoginVC.h"
@interface UserInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_detailNames;//详细信息
    NSArray *_titleNames;//名称
    
    NSString *_imageUrl;
   
    
}
@end
/**
 *  总共分为两组，1为基本信息 2账户信息
 */
@implementation UserInfoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    [self _makeData];
    [self _creatSubViews];
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
    [bottomButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.layer.cornerRadius = 5;
    [bottomView addSubview:bottomButton];
    
    _tableView.tableFooterView = bottomView;
}
/**
 *  退出请求
 */
-(void)logoutAction{
    //移除相对应的数据
    
    //token//openId//userId//UserPhone
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_Token];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_OpenId];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_UserId];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:JH_UserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //presentLoginVC
    LoginVC *login = [[LoginVC alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:login];
    
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
    
    
}
//创建内部的一些视图
-(void)_creatSubViews{
    //用户信息考虑到会发生变化故做成全局的
 
    
}
/**
 *  处理数据
 */
-(void)_makeData{
    
    if (_userModel!=nil) {
        //判断数据的有效性
        NSString *citycode = _userModel.cityCode;
        NSString *nickName = _userModel.nickName;
        
        //昵称
        if (nickName==nil) {
            nickName = @"";
        }
        
        //获取头像
        _imageUrl = _userModel.headUrl;
        //城市
        if (citycode==nil) {
            citycode = @"请选择";
        }else{
            
            citycode = [NSString CodeNameToName:citycode];
        }

        
        NSString *isAuthentication;
        
        //处理用户状态
        if ([_userModel.state isEqualToString:@"00"]) {
            isAuthentication = @"未认证";
        }else if ([_userModel.state isEqualToString:@"01"]){
            isAuthentication = @"已认证";
        }else{
            isAuthentication = @"已注销";
        }
        //处理微信绑定
        NSString *isOpenId;
        if (_userModel.openId == nil) {
            isOpenId = @"未绑定";
        }else{
            isOpenId = @"已绑定";
        }
        
        
        _detailNames = @[@"",nickName,citycode,_userModel.inviterName,isAuthentication,_userModel.mobileNo,isOpenId];
    }
    _titleNames = @[@"头像",@"昵称",@"所在城市",@"邀请人",@"实名认证",@"手机号",@"微信绑定"];
 
    [_tableView reloadData];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return section?2:5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *userInfoCell = @"userInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userInfoCell];
    }
    
    if (indexPath.section==1) {
        cell.textLabel.text = _titleNames[indexPath.row+5];
        cell.detailTextLabel.text = _detailNames[indexPath.row+5];
    }else{
        cell.textLabel.text = _titleNames[indexPath.row];
        cell.detailTextLabel.text = _detailNames[indexPath.row];
        //第一行第一列为图片信息
        if(indexPath.row==0){
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH-40-50,15, 50, 50)];
            imageView.layer.cornerRadius = imageView.width/2;
            imageView.layer.masksToBounds = YES;
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage LoadImageFromBundle:JH_BaseImage]];
            [cell.contentView addSubview:imageView];
        }
     
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 80;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
//头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *headerTitle = @[@"基本信息",@"账号信息"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH-20, 30)];
    label.text = headerTitle[section];
    label.textColor = [UIColor redColor];
    //左边还有一个图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 5, 20)];
    imageView.image = [UIImage imageNamed:@"i"];
    
    [view addSubview:imageView];
    
    [view addSubview:label];
    return view;
  
}
#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==4) {//身份认证
        AuthenticationVC *authentication = [[AuthenticationVC alloc] init];
       
        [self _pushViewController:authentication];
    }
    if (indexPath.section==0&&indexPath.row==3) {//我的邀请人
        MyInviterVC *inviter = [[MyInviterVC alloc] init];
        
        inviter.inviterId = _userModel.inviterId;
        //接收邀请人改变的通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_changeUserInviter:) name:JH_UserInviterChange object:nil];
        
        [self _pushViewController:inviter];
    }
    if (indexPath.section==0&&indexPath.row==0) {//我的头像
         MyHeadPortrait *head = [[MyHeadPortrait alloc] init];
        
        head.imageUrl = _imageUrl;
        //获取新的头像地址
        [head setImageBlock:^(NSString *imageUrl){
            _imageUrl = imageUrl;
            [_tableView reloadData];
            
        }];
        [self _pushViewController:head];
    }
    if (indexPath.section==0&&indexPath.row==1) {//昵称
        NickNameVC *nickName = [[NickNameVC alloc] init];
        
        nickName.nickname = _userModel.nickName;
        //获取新的昵称
        [nickName setNicknameBlock:^(NSString *newNickname){
            
            self.userModel.nickName = newNickname;
            [self _makeData];
            
        }];
        
        [self _pushViewController:nickName];
    }
    if (indexPath.section==0&&indexPath.row==2) {//城市
        AddressVC *address = [[AddressVC alloc] init];
        [self _pushViewController:address];
        //通知获取新的地址
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_changeUserCity:) name:JH_UserCityChange object:nil];
    }
    if (indexPath.section==1&&indexPath.row==0) {//手机号
        CheckPhoneVC *phone = [[CheckPhoneVC alloc] init];
        [self _pushViewController:phone];
        //通知获取新的手机号
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_changeUserMobile:) name:JH_UserMobileChange object:nil];
    }
    
}
//通知方法
-(void)_changeUserCity:(NSNotification *)notifi{
    NSString *city = notifi.userInfo[@"city_code"];
    _userModel.cityCode = city;
    
    [self _makeData];
}
-(void)_changeUserInviter:(NSNotification *)notifi{
    NSString *inviteName = notifi.userInfo[@"inviteName"];
    NSNumber *inviteId = notifi.userInfo[@"inviteId"];
    _userModel.inviterName = inviteName;
    _userModel.inviterId = [inviteId integerValue];
    [self _makeData];
}
-(void)_changeUserMobile:(NSNotification *)notifi{
    NSString *mobileNo = notifi.userInfo[@"mobileNo"];
    _userModel.mobileNo = mobileNo;
    
    [self _makeData];
}
/**
 *  移除通知
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
