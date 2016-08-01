//
//  MyPointVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MyPointVC.h"
#import "MyPointCell.h"
#import "BonusPoint.h"
@interface MyPointVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UILabel *_pointLabel;
    NSMutableArray *_bonusPointArray;
}
@end

@implementation MyPointVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    
    [self _creatTableView];
    
    [self _creatHeaderView];
    
    [self _makeData];
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
/**
 *创建头部的一些视图
 */
-(void)_creatHeaderView{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170)];
    //图片
    UIImageView *moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-40, 20, 80, 80)];
    moneyImageView.image = [UIImage imageNamed:@"我的积分"];
    moneyImageView.layer.cornerRadius = moneyImageView.width/2;
    moneyImageView.layer.masksToBounds = YES;
    //积分label
    _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, moneyImageView.bottom+10, SCREENWIDTH, 20)];
    _pointLabel.textColor = [UIColor redColor];
    _pointLabel.textAlignment = NSTextAlignmentCenter;
    
    _pointLabel.text = @"0.0";
    //积分明细
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, _pointLabel.bottom+20, SCREENWIDTH-20, 1)];
    lineView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    UILabel *staticlabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-50, _pointLabel.bottom+10, 100, 20)];
    staticlabel.textColor = [UIColor lightGrayColor];
    staticlabel.textAlignment = NSTextAlignmentCenter;
    staticlabel.backgroundColor = [UIColor whiteColor];
    staticlabel.text = @"积分明细";
    //上面有个积分规则介绍
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-150, 20, 140, 25)];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [button setImage:[UIImage imageCompressWithSimple:[UIImage imageNamed:@"问号"] scaledToSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
    button.titleLabel.font = SYSFONT14;
    [button setTitle:@"积分规则" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    
    [headView addSubview:button];
    
    [headView addSubview:moneyImageView];
    [headView addSubview:_pointLabel];
    [headView addSubview:lineView];
    [headView addSubview:staticlabel];
 
    _tableView.tableHeaderView = headView;
}
/**
 *  处理数据
 */
-(void)_makeData{
    /**
     *  获取数据
     */
    if (_bonusPointArray==nil) {
        
        _bonusPointArray = [NSMutableArray array];
    }
    
    NSString *urlString1 = @"getBonusPointRecord.json";
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
            NSNumber *bonusPoint = data[@"bonusPoint"];
            
            _pointLabel.text = [NSString stringWithFormat:@"%@",bonusPoint];
            
            NSArray *bonusRecordList = data[@"bonusRecordList"];
            if (bonusRecordList!=nil) {
                for (NSDictionary *recorde in bonusRecordList) {
                     BonusPoint *point = [BonusPoint mj_objectWithKeyValues:recorde];
                    
                    [_bonusPointArray addObject:point];

                }
            }else{
                
            }

            /**
             *  关闭进度条
             */
            
            [SVProgressHUD dismiss];
            
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _bonusPointArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MyPointCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyPointCell" owner:self options:nil]firstObject];
    cell.model = _bonusPointArray[indexPath.row];
    return cell;
}

#pragma mark - tableViewDataDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
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
