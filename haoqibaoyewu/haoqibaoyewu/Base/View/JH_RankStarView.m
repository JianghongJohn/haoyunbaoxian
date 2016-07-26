//
//  JH_RankStarView.m
//  PersentViewTest
//
//  Created by hyjt on 16/7/14.
//  Copyright © 2016年 hyjt. All rights reserved.
//

#import "JH_RankStarView.h"

@implementation JH_RankStarView
{
    UIView *_starView;
}
- (instancetype)initWithFrame:(CGRect)frame withRank:(CGFloat )starNum
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _creatStarView:starNum];
    }
    return self;
}
/**
 *  创建视图
 */
-(void)_creatStarView:(CGFloat )rank{
    /**
     *  实现思路
     1.创建一个1*5的视图，利用一个星星图片进行绘图
     */
    if (_starView==nil) {
        _starView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_starView];
        UIImage *image = [UIImage imageNamed:@"sta1"];
        image = [self imageCompressWithSimple:image scaledToSize:self.frame.size changeragnk:rank];
//        _starView.contentMode = UIViewContentModeScaleAspectFit;
        _starView.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    
}
-(UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size changeragnk:(CGFloat )rank
{
    UIGraphicsBeginImageContext(size);
    for (int star = 0; star<rank; star++) {
        [image drawInRect:CGRectMake(size.height*star,0,size.height,size.height)];
    }
    
    UIImage*newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
