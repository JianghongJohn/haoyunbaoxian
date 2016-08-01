//
//  UnPaidCustomerVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/8/1.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "UnPaidCustomerVC.h"
#import "UnPaidDetailCell.h"
#import "UnPaidModel.h"
@interface UnPaidCustomerVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_FirstSectionTitle;
    NSMutableArray *_proposalList;
}

@end

@implementation UnPaidCustomerVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"客户详情";
    
    [self _makeData];
    [self _creatTableView];
    
}
/**
 *  处理数据
 */
-(void)_makeData{
    /**
     *  获取数据
     */
    if (_proposalList==nil) {
        _proposalList  = [NSMutableArray array];
    }
    
    NSString *urlString1 = @"unPaidCustomerDetail.json";
    NSDictionary *parameters1 =  @{
                                   @"customerId": _customerId,
                                   @"vehicleId": _vehicleId,
                                   @"licensePlateNumber": _licensePlateNumber,
                                   
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
            
            
            _FirstSectionTitle = @[[NSString stringWithFormat:@"%@       %@",data[@"customerName"],data[@"licensePlateNumber"]],[NSString stringWithFormat:@"手机号       %@",data[@"phoneNumber"]],[NSString stringWithFormat:@"身份证号    %@",data[@"ownerCertNo"]]];
            
            /**
             *  关闭进度条
             */
            NSArray *proposalList = dic[@"quotationRecordDtos"];
            if (proposalList!=nil) {
                
                for (NSDictionary *dic in proposalList) {
                    
                    UnPaidModel *model = [UnPaidModel mj_objectWithKeyValues:dic];
                    [_proposalList addObject:model];
                }
            }
            
            
            [_tableView reloadData];
            
            [SVProgressHUD dismiss];
            
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"errorMsg"]];
            
            
        }
        
        
    } errorHandle:^(NSError *error) {
        
    }];

}
/**
 *  tableView
 */

-(void)_creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopBarHeight, SCREENWIDTH, SCREENHEIGHT-kTopBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}
#pragma mark - tableViewDATASource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return section?_proposalList.count:3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.section==0) {
        static NSString *customerInfoCell = @"customerInfoCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customerInfoCell];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:customerInfoCell];
        }
        
        cell.textLabel.text = _FirstSectionTitle[indexPath.row];
        if (indexPath.row==0) {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageCompressWithSimple:[UIImage imageNamed:@"填写"] scaledToSize:CGSizeMake(30, 30)]];
        }
        return cell;
    }else{
        UnPaidDetailCell *cell = [[[NSBundle mainBundle ]loadNibNamed:@"UnPaidDetailCell" owner:self options:nil]firstObject];
        return cell;
    }
    
    
    
}
#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section?50:44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
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
