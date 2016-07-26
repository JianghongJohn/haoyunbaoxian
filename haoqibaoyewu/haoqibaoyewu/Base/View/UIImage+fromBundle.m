//
//  UIImage+fromBundle.m
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/7.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import "UIImage+fromBundle.h"

@implementation UIImage (fromBundle)
//从资源包中加载不会占内存
+(UIImage *)LoadImageFromBundle:(NSString *)imageName{
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName
                                                     ofType:nil];
    
    return [UIImage imageWithContentsOfFile:path];
}
@end
