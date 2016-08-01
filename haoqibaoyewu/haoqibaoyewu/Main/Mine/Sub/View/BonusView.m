//
//  BonusView.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/13.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "BonusView.h"

@implementation BonusView
{
    UILabel *_bonusLabel;
    UILabel *_titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withBonusNum:(NSString *)bonusNum withFont:(UIFont *)font{
    if (self==[super initWithFrame:frame]) {
        //绘制图形
        [self _creatsubViews:frame.size.width withHeight:frame.size.height withTitle:title withBonus:bonusNum withFont:font];
    }
    return self;
}
/**
 *  创建视图
 *
 *  @param width    视图大小
 *  @param title    名称
 *  @param bonusNum 奖金
 *  @param font     字体大小
 */
-(void)_creatsubViews:(CGFloat )width withHeight:(CGFloat )height withTitle:(NSString *)title withBonus:(NSString *)bonusNum withFont:(UIFont *)font{
    if (_bonusLabel==nil) {
        _bonusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height/2)];
        _bonusLabel.text = bonusNum;
        _bonusLabel.font = font;
        _bonusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bonusLabel];
    }
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height/2, width, height/2)];
        _titleLabel.text = title;
        _titleLabel.font = font;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    
}
/**
 *  设置属性
 */
-(void)setNonusNum:(NSString *)nonusNum{
    if (_nonusNum!=nonusNum) {
        _nonusNum = nonusNum;
        _bonusLabel.text = _nonusNum;
    }
}
-(void)setTitleColor:(UIColor *)titleColor{
    if (_titleColor!=titleColor) {
        _titleColor = titleColor;
        _titleLabel.textColor = _titleColor;
    }
}
-(void)setBonusColor:(UIColor *)bonusColor{
    if (_bonusColor!=bonusColor) {
        _bonusColor = bonusColor;
        _bonusLabel.textColor = _bonusColor;
    }
}
@end
