//
//  UIImage+ChangeToSize.h
//  haoqibaoyewu
//
//  Created by hyjt on 16/7/15.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ChangeToSize)
+(UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size;
+(UIImage*)JH_CircleImage:(UIImage *)image scaledToSize:(CGSize)size;
@end
