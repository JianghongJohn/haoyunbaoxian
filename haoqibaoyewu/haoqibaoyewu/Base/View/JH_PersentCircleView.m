//
//  JH_PersentCircleView.m
//  PersentViewTest
//
//  Created by hyjt on 16/7/14.
//  Copyright © 2016年 hyjt. All rights reserved.
//

#import "JH_PersentCircleView.h"
/**
 *  这是一个现实百分比的视图
 */
@implementation JH_PersentCircleView
{
    UILabel *_persentLabel;
}
//-(instancetype)initWithFrame:(CGRect)frame andPersent:(CGFloat)persent{
//    if (self==[super initWithFrame:frame]) {
//
//        [self _creatLabel];
//    }
//    return self;
//    
//}
//-(void)awakeFromNib{
//    
//}
-(void)_creatLabel{
    //获取当前视图大小
    CGFloat width = self.frame.size.width;
    //居中
    _persentLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2/2, width/2/2, width/2, width/2)];
    
    _persentLabel.textAlignment = NSTextAlignmentCenter;
    
    _persentLabel.textColor = [UIColor blackColor];
    
    [self addSubview:_persentLabel];
}
-(void)drawRect:(CGRect)rect{
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self _drawCircle:context];
    [self _drawRedCircle:context];
    
}
//这个是底部圆圈
-(void)_drawCircle:(CGContextRef )context{
    //获取视图大小
    CGFloat width = self.frame.size.width;
    //添加圆形
    CGContextAddArc(context, width/2, width/2, (width-10)/2, 0, M_PI * 2, 0);
    [[UIColor lightGrayColor] setStroke];
    
    CGContextSetLineWidth(context, 5);
    
    CGContextDrawPath(context, kCGPathStroke);
    
}

-(void)setPersent:(CGFloat)persent{
    if (_persent!=persent) {
        _persent=persent;
    }
    if (_persentLabel==nil) {
        //获取当前视图大小
        CGFloat width = self.frame.size.width;
        //居中
        _persentLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2/2, width/2/2, width/2, width/2)];
        
        _persentLabel.textAlignment = NSTextAlignmentCenter;
        
        _persentLabel.textColor = [UIColor blackColor];
        
        [self addSubview:_persentLabel];

    }
    _persentLabel.text = [NSString stringWithFormat:@"%.0f%%",_persent*100];
    
}
-(void)setFont:(UIFont *)font{
    if (_font!=font) {
        _font = font;
    }
    if (_persentLabel==nil) {
        //获取当前视图大小
        CGFloat width = self.frame.size.width;
        //居中
        _persentLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2/2, width/2/2, width/2, width/2)];
        
        _persentLabel.textAlignment = NSTextAlignmentCenter;
        
        _persentLabel.textColor = [UIColor blackColor];
        
        [self addSubview:_persentLabel];
        
    }
    _persentLabel.font = _font;
}
/**
 *  绘制红色图形
 *
 *  @param context 图形上下文
 */
-(void)_drawRedCircle:(CGContextRef )context{
    //获取视图大小
    CGFloat width = self.frame.size.width;
    //添加圆形
    CGContextAddArc(context, width/2, width/2, (width-10)/2, 0, M_PI * 2*_persent, 0);
    [[UIColor redColor] setStroke];
    
    CGContextSetLineWidth(context, 5);
    
    CGContextDrawPath(context, kCGPathStroke);
    
}





@end
