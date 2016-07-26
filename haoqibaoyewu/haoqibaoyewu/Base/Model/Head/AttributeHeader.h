//
//  AttributeHeader.h
//  haoqibaoyewu
//
//  Created by jianghong on 16/7/5.
//  Copyright © 2016年 jianghong. All rights reserved.
//

#ifndef AttributeHeader_h
#define AttributeHeader_h
#define UIIMAGE(imageName) [UIImage imageNamed:imageName]

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define IOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )

#define APPDELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate

#define kStatusBarHeight   (20.f)
#define kTopBarHeight      (64.f)
#define kBottomBarHeight   (49.f)

#define SYSFONT12 [UIFont systemFontOfSize:12]
#define SYSFONT13 [UIFont systemFontOfSize:13]
#define SYSFONT14 [UIFont systemFontOfSize:14]
#define SYSFONT15 [UIFont systemFontOfSize:15]
#define SYSFONT16 [UIFont systemFontOfSize:16]
#define SYSFONT17 [UIFont systemFontOfSize:17]


#endif /* AttributeHeader_h */
