//
//  QuestionAnswerVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "QuestionAnswerVC.h"
#import "UIImage+ChangeToSize.h"

#define tableHeight 44*3+50*2+10
@interface QuestionAnswerVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_imageNames;
    NSArray *_titleNames;
    UIView *_secondView;
}
@end
/**
 *  问题咨询
 */
@implementation QuestionAnswerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题咨询";
    
    [self _creatSecondView];
    
    [self _creatTableView];
    
    [self _creatBottomView];
    
}
/**
创建表视图
 */
-(void)_creatTableView{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight+10, SCREENWIDTH, tableHeight)style:UITableViewStylePlain];
    //禁止滚动
    tableview.scrollEnabled = NO;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    _imageNames = @[@"报价环节",@"配送问题",@"支付环节"];
    _titleNames = @[@"报价问题",@"配送问题",@"支付环节"];
}
/**
 *  创建第二组的布局
 */
-(void)_creatSecondView{
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    //两个带文字图片的button
    UIButton *phoneCall = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH/2, 30)];
    [_secondView addSubview:phoneCall];
    [phoneCall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phoneCall setTitle:@"客服热线" forState:UIControlStateNormal];
    [phoneCall setImage:UIIMAGE(@"客服热线") forState:UIControlStateNormal];
    
    UIButton *onlinePhoneCall = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/2, 10, SCREENWIDTH/2, 30)];
    [_secondView addSubview:onlinePhoneCall];
    [onlinePhoneCall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onlinePhoneCall setTitle:@"在线客服" forState:UIControlStateNormal];
  
    [onlinePhoneCall setImage:UIIMAGE(@"在线客服") forState:UIControlStateNormal];
    
    //加一个线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2, 5, 0.5, 40)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_secondView addSubview:lineView];
    
}
-(void)_creatBottomView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kTopBarHeight+10+tableHeight, SCREENWIDTH, 30)];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"工作时间：9：00~21：00";
    label.font = SYSFONT14;
    label.textAlignment = NSTextAlignmentCenter;
    
}
#pragma mark - TableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return section?1:3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *QACell = @"QACell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QACell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QACell];
    }
    if (indexPath.section==0) {
        cell.imageView.image = [UIImage imageCompressWithSimple:[UIImage imageNamed:_imageNames[indexPath.row]] scaledToSize:CGSizeMake(30, 30)];
        cell.textLabel.text = _titleNames[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        [cell.contentView addSubview:_secondView];
    }
    
    return cell;
}

#pragma mark - tableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView *headBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
    //一个图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12.5, 25, 25)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"常见问题"];
        [headBaseView addSubview:imageView];
        
    //一个标题
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+10, 10, 100, 30)];
        [headBaseView addSubview:label];
        label.text = @"常见问题";
    //添加一些辅助线
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(0, headBaseView.height-0.5, SCREENWIDTH, 0.5)];
        verticalLine.backgroundColor = [UIColor lightGrayColor];
        [headBaseView addSubview:verticalLine];
        
        return headBaseView;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?10:50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 44;
    }
    return 50;
    
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
