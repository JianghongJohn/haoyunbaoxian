//
//  UILabel+AutoSize.h
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/8.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoSize)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
