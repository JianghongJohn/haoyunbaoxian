//
//  UIImage+ChangeToSize.m
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/15.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "UIImage+ChangeToSize.h"

@implementation UIImage (ChangeToSize)
/**
 *  图片缩放
 *  @param image 传入图片
 *  @param size  需要的图片大小
 *  @return 返回新图片
 */
+(UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    
    UIImage*newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  将图片变成圆形
 *  @param image 传入图片
 *  @return 返回圆形的图片
 */
+(UIImage*)JH_CircleImage:(UIImage *)image scaledToSize:(CGSize)size{
    // self -> 圆形图片
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(size);
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0,0,size.width,size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 绘制图片到圆上面
    [image drawInRect:rect];
    
    // 获得图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;

}
@end
