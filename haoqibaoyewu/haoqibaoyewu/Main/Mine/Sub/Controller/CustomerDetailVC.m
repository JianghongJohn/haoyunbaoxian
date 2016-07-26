//
//  CustomerDetailVC.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/18.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "CustomerDetailVC.h"
#import "CustomerCell.h"
@interface CustomerDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_FirstSectionTitle;
}
@end

@implementation CustomerDetailVC

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
    _FirstSectionTitle = @[@"吴亦凡       沪A12345",@"手机号       15757166458",@"身份证号    330327199306296814"];
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
    return section?4:3;
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
        CustomerCell *cell = [[[NSBundle mainBundle ]loadNibNamed:@"CustomerCell" owner:self options:nil]firstObject];
        return cell;
    }
    
    
    
}
#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section?100:44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
