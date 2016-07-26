//
//  MineWalletCell.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/12.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "MineWalletCell.h"
#import "MyPointVC.h"
#import "MyWalletVC.h"
@implementation MineWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *walletTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(walletAction)];
    
    [_walletLabel addGestureRecognizer:walletTap];
    _walletLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *walletTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(walletAction)];
    
    [_walletStaticLabel addGestureRecognizer:walletTaps];
    _walletStaticLabel.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *pointTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointAction)];
    
    [_pointLabel addGestureRecognizer:pointTap];
    _pointLabel.userInteractionEnabled = YES;

    
    UITapGestureRecognizer *pointTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointAction)];
    
    [_pointStaticLabel addGestureRecognizer:pointTaps];
    _pointStaticLabel.userInteractionEnabled = YES;

}
-(void)walletAction{
    /**
     *  我的钱包
     */
    MyWalletVC *wallet = [[MyWalletVC alloc] init];
    wallet.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:wallet animated:YES];
}
-(void)pointAction{
    /**
     *  我的积分
     */
          MyPointVC *point = [[MyPointVC alloc] init];
        point.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:point animated:YES];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setPointAmount:(NSString *)pointAmount{
    if (_pointAmount!=pointAmount) {
        _pointAmount = pointAmount;
        _pointLabel.text = _pointAmount;
    }
    
}
-(void)setWalletAmount:(NSString *)walletAmount{
    if (_walletAmount!=walletAmount) {
        _walletAmount = walletAmount;
        _walletLabel.text = _walletAmount;
    }
}



@end
