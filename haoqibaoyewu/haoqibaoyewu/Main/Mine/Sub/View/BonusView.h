//
//  BonusView.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/13.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BonusView : UIView
@property(nonatomic,copy)NSString * nonusNum;
@property(nonatomic,strong)UIColor *bonusColor;
@property(nonatomic,strong)UIColor *titleColor;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withBonusNum:(NSString *)bonusNum withFont:(UIFont *)font;
@end
